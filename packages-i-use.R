# if (!require("remotes")) install.packages("remotes")

# for RStudio Theme
remotes::install_cran(
  "rsthemes",
  repos = c(gadenbuie = "https://gadenbuie.r-universe.dev", getOption("repos"))
)

rsthemes::install_rsthemes()
# rsthemes::set_theme_dark('One Dark {rsthemes}')

remotes::install_github(
  c(
    "clauswilke/colorblindr",
    "dcomtois/sortLines" # for sorting lines in RStudio
  ),
  force = FALSE
)

remotes::install_cran(
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
    "glmnet",
    "lme4",
    "ltm",
    "LongituRF",
    "pwr",
    "quantmod",
    "ranger",
    "vip",

    # plotting / visuals / tables
    "DiagrammeR",
    "dotwhisker",
    "flextable",
    "ggstatsplot",
    "ggthemes",
    "ggtext",
    "gtsummary",
    "kableExtra",
    "mapproj",
    "mapview",
    "multilevelmod",
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
    "pak",

    # misc
    "addinslist",
    "crsuggest",
    "janitor",
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
    "tidycoder",
    "tidygeocoder"
  )
)


rio::install_formats()
