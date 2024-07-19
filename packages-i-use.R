# install.packages(c('languageserver', 'Rcpp', 'RcppArmadillo'))

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
  )
)


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
