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
