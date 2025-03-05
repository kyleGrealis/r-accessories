install.packages('tidyverse')
install.packages("remotes")

remotes::install_cran(c('froggeR', 'nascaR.data'))
remotes::install_github('hadley/emo')

remotes::install_cran("pak")

# remotes::install_cran(
pak::pak(
  c(
    "arrow",
    "BH",
    "fstcore",
    "RApiSerialize",
    "stringfish",

    # Shiny packages:
    "bslib",
    "shiny",

    # webscraping
    "applicable",

    # modeling / stats
    "doParallel",
    "lme4",
    "ltm",
    "pins",
    "plumber",
    "pwr",
    "quantmod",
    "ranger",
    "vetiver",
    "vip",

    # plotting / visuals / tables
    "DiagrammeR",
    "extrafont",
    "flextable",
    "gfonts",
    "ggiraph",
    "ggstatsplot",
    "ggthemes",
    "ggtext",
    "gtsummary",
    "kableExtra",
    "pandoc",
    "patchwork",
    "reactable",
    "reactablefmtr",
    "table1",
    "textrecipes",
    "vcd",
    "vcdExtra",
    "viridis",

    # for package development
    "available",
    "devtools",

    # misc
    "crsuggest",
    "janitor",
    "lorem",
    "palmerpenguins",
    "quarto",
    "qpcR",
    "redcapAPI",
    "rio",
    "rUM",
    "sjlabelled",
    "skimr",
    "tidyREDCap"

  )
)


rio::install_formats()
