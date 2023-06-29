if (!require('remotes')) install.packages('remotes')

# for RStudio Theme
remotes::install_cran(
  'rsthemes',
  repos = c(gadenbuie = 'https://gadenbuie.r-universe.dev', getOption('repos'))
)

rsthemes::install_rsthemes()
# rsthemes::set_theme_dark('One Dark {rsthemes}')

remotes::install_github(
  c(
    'hadley/emo',
    'jhelvy/xaringanBuilder',
    'rstudio/chromote',
    'clauswilke/colorblindr'
  ),
  force = FALSE
)

remotes::install_cran(
  c(
    # Shiny packages:
    'bs4Dash',
    'miniUI',
    'reactlog',
    'shiny',
    'shinycssloaders',
    'shinydashboard',
    'shinyFeedback',
    'shinyjs',
    'shinyMobile',
    'shiny.semantic',
    'shinythemes',
    'shinyWidgets',
    'waiter',
    
    # webscraping
    'applicable',
    'xml2',
    
    # modeling / stats
    'tidymodels',
    'doParallel',
    'glmnet',
    'lme4',
    'ltm',
    'pwr',
    'quantmod',
    'ranger',
    'vip',
    
    # plotting / visuals / tables
    'DiagrammeR',
    'dotwhisker',
    'ggstatsplot',
    'ggthemes',
    'ggtext',
    'gt',
    'gtsummary',
    'kable',
    'kableExtra',
    'mapproj',
    'maps',
    'plotly',
    'reactable',
    'reactablefmtr',
    'rpart.plot',
    'table1',
    'textrecipes',
    'text2vec',
    'thematic',
    'vcd',
    'vcdExtra',
    'viridis',
    
    # for package development
    'available',       
    'devtools',
    'gh',
    'gitcreds',
    'pak',
    'pkgbuild',
    'roxygen2',
    'testthat',
    'usethis',
    
    # misc
    'conflicted',
    'glue',
    'haven',
    'here',
    'janitor',
    'jsonlite',
    'knitr',
    'lintr',
    'markdown',
    'quarto',
    'ragg',
    'redcapAPI',
    'rio',
    'rmarkdown',
    'rsconnect',
    'rUM',
    'skimr',
    'styler',
    'tidyREDCap',
    'tidyverse',
    'yaml',
    
    # more tidy stuff
    'tidycensus',
    'tidycoder'
  ),
  # type = 'binary',
  force = FALSE
)


rio::install_formats()