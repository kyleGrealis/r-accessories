if (!require("remotes")) install.packages("remotes")

# for RStudio Theme
# remotes::install_cran(
#   "rsthemes",
#   repos = c(gadenbuie = "https://gadenbuie.r-universe.dev", getOption("repos"))
# )
# 
# rsthemes::install_rsthemes()
# # rsthemes::set_theme_dark('One Dark {rsthemes}')

install.packages("pak")

# remotes::install_github(
pak::pkg_install(
  c(
    "clauswilke/colorblindr",
    "mlverse/chattr",
    "dcomtois/sortLines" # for sorting lines in RStudio
  ),
  # force = FALSE
)


# remotes::install_cran(
pak::pak(
  c(
    # Shiny packages:
    "bslib",
    "shiny",
    "shinydashboard",
    "shinyjs",
    "shiny.router",
    "shiny.semantic",

    # webscraping
    "applicable",

    # modeling / stats
    "tidymodels",
    "broom.mixed",
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
    "dotwhisker",
    "extrafont",
    "flextable",
    "ggiraph",
    "ggstatsplot",
    "ggthemes",
    "ggtext",
    "gtsummary",
    "kableExtra",
    "mapproj",
    "mapview",
    "multilevelmod",
    "patchwork",
    "plotly",
    "reactable",
    "reactablefmtr",
    "rpart.plot",
    "table1",
    "textrecipes",
    "text2vec",
    "thematic",
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
    "tidyREDCap",

    # more tidy stuff
    "tidycensus",
    "tidygeocoder"
  )
)


rio::install_formats()
