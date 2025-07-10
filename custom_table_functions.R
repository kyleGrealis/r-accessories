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


#' Clean gtsummary table display
#'
#' @param tbl A gtsummary table object
#' @return A modified gtsummary table object with cleaned display values
#'
#' @description
#' Improves table readability by:
#' 1. Replacing "0 (NA%)" and "NA (NA)" with "--"
#' 2. Only shows actual data, making it easier to spot real values
#'
#' @details
#' The function uses modify_table_body() to transform character columns in the table.
#' It specifically targets two types of empty data representations:
#' - "0 (NA%)" which appears when no events occurred but percentages can't be calculated
#' - "NA (NA)" which appears for completely missing data
#'
#' @examples
#' your_data |>
#'   tbl_summary() |>
#'   clean_table()
clean_table <- function(tbl) {
  tbl |>
    modify_table_body(
      ~ .x |>
        mutate(across(
          where(is.character),
          ~ ifelse(
            . %in% c("0 (NA%)", "NA (NA)", "0 (0%)", "NA (NA, NA)", "NA, NA"),
            "--",
            .
          )
        ))
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

#' Simplify adding gt table options
#'
#' @param x gt table object
#' @return A modified gt table with included display options
extras <- function(x) {
  x |>
    add_overall(last = TRUE) |>
    add_p(
      test = list(
        all_continuous() ~ "t.test",
        all_categorical() ~ "chisq.test"
      ),
      pvalue_fun = ~ style_pvalue(.x, digits = 3)
    ) |> 
    bold_labels() |> 
    modify_header(label ~ "") |>
    # from above
    clean_table()
}


# Misc table tweaks
date <- Sys.Date() |> format("%B %d, %Y")
subtitle <- glue("Processed: {date}")