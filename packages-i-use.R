install.packages("remotes")
install.packages("tidyverse")

remotes::install_cran(c("froggeR"))
remotes::install_github(c(
  "kyleGrealis/nascaR.data@weekly",
  "hadley/emo",
  "hollyyfc/lme4u"
))

remotes::install_cran("pak")

pak::pak(
  # remotes::install_cran(
  c(
    "arrow",
    "BH",
    "fstcore",
    "RApiSerialize",
    "stringfish",

    # Shiny packages:
    "bslib",
    "shiny",
    "shinyjs",

    # webscraping
    "applicable",

    # modeling / stats
    "tidymodels",
    "broom.mixed",
    "bonsai",
    "DALEX",
    "DALEXtra",
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
    "echarts4r",
    "extrafont",
    "flextable",
    "ggdist",
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
