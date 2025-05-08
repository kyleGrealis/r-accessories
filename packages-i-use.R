if (!require("remotes")) install.packages("remotes")

remotes::install_github("hadley/emo")
remotes::install_github("kyleGrealis/nascaR.data")
remotes::install_github("kyleGrealis/froggeR")

install.packages("pak")

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
    "tidymodels",
    "broom.mixed",
    "bonsai",
    "DALEX",
    "DALEXtra",
    "doParallel",
    "gee",
    "glmnet",
    "lme4",
    "ltm",
    "LongituRF",
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
    "ggiraph",
    "ggstatsplot",
    "ggthemes",
    "ggtext",
    "gtsummary",
    "kableExtra",
    "mapproj",
    "mapview",
    "patchwork",
    "table1",
    "textrecipes",
    "vcd",
    "vcdExtra",
    "viridis",

    # for package development
    "available",
    "devtools",

    # misc
    "addinslist",
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
