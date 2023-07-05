

# create tables for all factor and character variables within a dataset
factor_table <- function(dsn) {
  dsn |> 
    dplyr::select(
      where(~is.factor(.x) | is.character(.x))
    ) |> 
    purrr::imap(
      ~janitor::tabyl(.x) |> 
        rename(!!.y := 1) |> 
        janitor::adorn_pct_formatting(1)
    )
}

# example:
palmerpenguins::penguins |> factor_table()
