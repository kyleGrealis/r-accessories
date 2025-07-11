#' Find a variable in a dataset
#' @description Easily find which dataset(s) a variable name is in.
#' @param var_name The variable to find
#' @examples
#' find_variable('record_id')
find_variable <- function(var_name) {
  # Get all objects in the environment
  all_objects <- ls(envir = .GlobalEnv)

  # Create a vector to store results
  found_in <- character(0)

  # Loop through objects and check their names
  for (obj_name in all_objects) {
    # Skip the function itself
    if (obj_name == "find_variable") {
      next
    }

    # Get the object
    obj <- get(obj_name, envir = .GlobalEnv)

    # Check if it's a data frame and contains the variable
    if (is.data.frame(obj) && var_name %in% names(obj)) {
      found_in <- c(found_in, obj_name)
    }
  }

  # Return results
  if (length(found_in) == 0) {
    return(paste0("Variable '", var_name, "' not found in any dataset"))
  } else {
    return(found_in)
  }
}
#' @noRd

#' Custom janitor::tabyl to stratify by site
#' @param var Variable of interest
a_tabyl <- function(dataset, var) {
  janitor::tabyl(dataset, {{ var }}, the_site)
}
#' @noRd

#' Drop the label from one or more variables
#' @description There is a reported issue with joins on data (without a reprex)
#' that seem to be caused by the labels. As a possible solution this can be
#' used to drop labels from one or more variables.
#'
#' @param df the name of the data frame
#' @param ... Variable selection using tidyselect helpers (e.g., contains(),
#' starts_with()) or column names as symbols or strings
#'
#' @examples
#' \{dontrun
#' # Remove labels from a single variable
#' df |> drop_label(employment)
#'
#' # Remove labels from multiple variables
#' df |> drop_label(employment, marital_status)
#'
#' # Remove all demograhic labels using tidyselect helpers
#' df |> drop_label(starts_with("dem_"))
#' }
#'
#' @export
#'
#' @return df with labels removed from selected variables
drop_label_kyle <- function(df, ...) {
  # Capture the variables using tidyselect
  vars_idx <- tidyselect::eval_select(rlang::expr(c(...)), df)

  # If no variables selected, return the dataframe as is
  if (length(vars_idx) == 0) {
    return(df)
  }

  # For each selected column, remove its attributes
  for (col_idx in vars_idx) {
    attributes(df[[col_idx]]) <- NULL
  }

  df
}


#' Modify tidyREDCap::make_yes_no() for only Yes or No, not Unknown
#' @description
#' The current make_yes_no() function includes a "Unknown" factor that is not always
#' needed to display the tables. This will only include Yes or No
#' 
#' @param x The variable to mutate.
#' @examples
#' df |> mutate(x = yes_no(x))
#' 
#' @export
yes_no <- function(x) {
  # Grab the label before we mess with the data
  original_label <- attr(x, "label")
  
  if (is.factor(x) | is.character(x)) {
      result <- factor(case_when(
          str_detect(x, stringr::regex("^yes", ignore_case = TRUE)) == TRUE ~ "Yes", 
          str_detect(x, stringr::regex("^checked", ignore_case = TRUE)) == TRUE ~ "Yes", 
          str_detect(x, stringr::regex("^no", ignore_case = TRUE)) == TRUE ~ "No", 
          str_detect(x, stringr::regex("^unchecked", ignore_case = TRUE)) == TRUE ~ "No", 
          TRUE ~ "No"
      ), levels = c("No", "Yes"))
  }
  else if (is.numeric(x) | is.logical(x)) {
      result <- factor(case_when(
          x == 1 ~ "Yes", 
          TRUE ~ "No"
      ), levels = c("No", "Yes"))
  }
  else {
      result <- x
  }
  
  # Put the label back if we had one
  if (!is.null(original_label)) {
      attr(result, "label") <- original_label
  }
  
  return(result)
}
