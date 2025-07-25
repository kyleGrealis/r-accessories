install.packages("remotes")
install.packages("tidyverse")

remotes::install_cran(c("froggeR"))
remotes::install_github(c(
  "kyleGrealis/nascaR.data",
  "hadley/emo",
  "hollyyfc/lme4u",
  "e-mitchell/meps_r_pkg/MEPS"
))

remotes::install_cran("pak")

install.packages(
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
    'glmnet',
    "lme4",
    "ltm",
    "pins",
    "plumber",
    'pROC',
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
    "ggfittext",
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
    "rhub",

    # misc
    "crsuggest",
    "janitor",
    "keyring",
    "lorem",
    "mockery",
    "nhanesA",
    "palmerpenguins",
    "propensity",
    "quarto",
    "qpcR",
    "qpdf",
    "redcapAPI",
    "redquack",
    "rio",
    "RSQLite",
    "rUM",
    "sjlabelled",
    "skimr",
    "tidyREDCap"
  )
)


rio::install_formats()
