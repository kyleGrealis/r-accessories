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
    'rstudio/chromote'
  ),
  force = FALSE
)

remotes::install_cran(
  c(
    # Shiny packages:
    'bs4dash',
    'shiny',
    'shinycssloaders',
    'shinydashboard',
    'shinyFeedback',
    'shinyJS',
    'shinyMobile',
    'shiny.semantic',
    'shinythemes',
    'shinyWidgets',
    
    
    
    'agua',
    'aorsf',
    'applicable',
    # 'arrow',
    'available',
    'baguette',
    'beeswarm',
    'bestNormalize',
    'bonsai',
    'broom.mixed',
    'brulee',
    'car',
    'censored',
    'conflicted',
    'devtools',
    'ggthemes',
    'ggtext',
    'gh',
    'gitcreds',
    'glue',
    'gt',
    'gtsummary',
    'haven',
    'here',
    'janitor',
    'jsonlite',
    'knitr',
    'mapproj',
    'maps',
    'markdown',
    'pak',
    'polite',
    'quarto',
    'ragg',
    'reactable',
    'redcapAPI',
    'rio',
    'rmarkdown',
    'roxygen2',
    'rsconnect',
    'rUM',
    'rvest',
    'skimr',
    'sparklr',
    'styler',
    'table1',
    'testthat',
    'thematic',
    'themis',
    'tidymodels',
    'tidyREDCap',
    'tidyverse',
    'usethis',
    'viridis',
    'yaml'
  ),
  # type = 'binary',
  force = FALSE
)

