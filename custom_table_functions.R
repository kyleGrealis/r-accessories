#' Filter dataset to timepoints with non-missing values
#'
#' @param data A data frame containing longitudinal data with a timepoint column
#'   named 'redcap_event_name'
#' @param ... One or more unquoted variable names to check for non-missing values
#'
#' @return A filtered and releveled data frame containing only timepoints where at least
#'   one specified variable has non-missing values
#'
#' @description
#' When analyzing longitudinal data, some variables may only be collected at specific
#' timepoints, resulting in NA values at other times. This function helps identify and
#' filter to only the relevant timepoints where data collection occurred. It's particularly
#' useful when creating summary tables or visualizations that should only show timepoints
#' with actual measurements.
#'
#' @details
#' The function performs three operations:
#' 1. Identifies timepoints where any specified variable has non-missing values
#' 2. Filters the dataset to keep only those timepoints
#' 3. Drops unused factor levels from the filtered dataset
#'
#' @examples
#' # Filter to timepoints where either baseline or 6-month measurements exist
#' data |>
#'   has_vals(baseline_measure, month_6_measure)
#'
#' # Use directly in a pipeline before creating summary tables
#' data |>
#'   select(timepoint, survey_measure_1, survey_measure_2) |>
#'   has_vals(survey_measure_1) |>
#'   tbl_summary(by = timepoint)
has_vals <- function(data, ...) {
  timepoints <- data |>
    filter(if_any(c(...), ~ !is.na(.))) |>
    pull(redcap_event_name) |>
    unique()

  data |>
    filter(redcap_event_name %in% timepoints) |>
    droplevels()
}


#' Clean NA patterns in gtsummary tables
#'
#' @param tbl A gtsummary table object
#' @return A modified gtsummary table object with cleaned display values
#'
#' @description
#' Improves table readability by automatically detecting and replacing various
#' NA patterns with a clean em-dash symbol. Works with any statistic format
#' and gtsummary table type. The purpose is to remove visual noise from tables,
#' especially where there are many missing values, making it easier to quickly
#' identify and focus on the actual data.
#'
#' @details
#' This function uses a two-step process:
#' 1. **Pattern Detection**: Uses regex to identify cells containing "NA" or "Inf"
#'    patterns in statistic columns, regardless of the specific format
#' 2. **Clean Replacement**: Leverages gtsummary's built-in `modify_missing_symbol()`
#'    to replace detected patterns with "---"
#'
#' Common patterns detected include:
#' - `"NA (NA)"` - missing mean/SD
#' - `"0 (NA%)"` - zero counts with undefined percentages
#' - `"NA [NA, NA]"` - missing median/quartiles
#' - `"NA ± NA (range: Inf - Inf)"` - missing complex statistics
#' - Any other combination containing "NA" or "Inf"
#'
#' The function specifically targets statistic columns and appropriate row types,
#' leaving variable names and labels untouched.
#'
#' @examples
#' library(gtsummary)
#'
#' # Basic usage
#' trial |>
#'   tbl_summary() |>
#'   clean_gtsummary_nas()
#'
#' # Works with custom statistics
#' trial |>
#'   tbl_summary(
#'     statistic = all_continuous() ~ "{mean} ± {sd} (range: {min} - {max})"
#'   ) |>
#'   clean_gtsummary_nas()
#'
#' @export
clean_gtsummary_nas <- function(tbl) {
  tbl |>
    modify_table_body(
      ~ .x |>
        mutate(across(
          all_stat_cols(),
          ~ {
            # Detect any statistic containing "NA" or "Inf" using word boundaries
            # \\b ensures we match complete words, avoiding false positives
            na_pattern <- "\\bNA\\b|\\bInf\\b"
            if_else(str_detect(., na_pattern), NA_character_, .)
          }
        ))
    ) |>
    modify_missing_symbol(
      symbol = "---",
      columns = all_stat_cols(),
      rows = 
        (var_type %in% c("continuous", "dichotomous") & row_type == "label") |
        (var_type %in% c("continuous2", "categorical") & row_type == "level")
    )
}


#' Custom gt table theme
#'
#' @param tbl gt table object
#' @return A modified gt table with adapted gtsummary::theme_gtsummary_compact theme
#'
#' @description
#' Since the gt package does not have its own version of a compact theme, this has
#' been adapted by running \code{theme_gtsummary_compact} in the console and
#' using the provided output. This tries to keep consistent with the 'jama' theme.
#'
#' @examples
#' your_data |>
#'   gt() |>
#'   theme_gt_compact()
theme_gt_compact <- function(tbl) {
  tbl |>
    tab_options(
      table.font.size = px(13),
      data_row.padding = px(1),
      summary_row.padding = px(1),
      grand_summary_row.padding = px(1),
      footnotes.padding = px(1),
      source_notes.padding = px(1),
      row_group.padding = px(1),
      # Add other styling from the JAMA theme
      # heading.background.color = "#f8f9fa",
      heading.title.font.weight = "bold",
      column_labels.font.weight = "bold",
      table.border.top.style = "hidden",
      table.border.bottom.style = "hidden"
    )
}
