library(tidyverse)
library(knitr)
library(kableExtra)

most_frequent <- function(df, top_n) {
  # pivot the original dataset so the common values can be counted
  long_df <-
    df |> 
    # create a longer dataset
    pivot_longer(
      cols = everything(),
      names_to = 'original_column',
      values_to = 'value'
    ) |> 
    group_by(value) |> 
    summarize(
      n = n()
    ) |> 
    arrange(desc(n)) |> 
    # save the top_n recurring values and their count
    head(n = top_n)
  return(long_df)
}

colors_and_italics <- function(df, freq) {
  df |> 
    mutate(
      across(
        everything(),
        ~ cell_spec(
          .,
          # change font color if in top occurring values
          color = case_when(
            . %in% freq$value[1] ~ "red",
            . %in% c(freq$value[2:nrow(freq)]) ~ 'black',
            TRUE ~ "gray"
          ),
          # make italicized if in top occurring values
          italic = ifelse(. %in% freq$value, TRUE, FALSE)
        )
      )
    ) |> 
    kable(escape = FALSE, booktabs = TRUE,) |>
    kable_styling(full_width = FALSE)
}

# put both functions together to render the final table
colored_freq_table <- function(df, top_n_values) {
  freq <- most_frequent(fruits, top_n_values)
  colors_and_italics(df, freq)
}
