
# do before running more ------------------------------------------------------------

# Make a free OpenAI account
# Create OpenAI API key: https://platform.openai.com/account/api-keys

# get ChatGPT3 plug in running ------------------------------------------------------

remotes::install_cran('gptstudio', force = FALSE)
library(gptstudio)

# set API key ----
Sys.setenv(OPENAI_API_KEY = ' < your_api_key > ')


# other method ----------------------------------------------------------------------

remotes::install_cran(c('gptstudio', 'usethis'), force = FALSE)
library(gptstudio)
library(usethis)

usethis::edit_r_environ()
# then add OPENAI_API_KEY = ' < your_api_key > '
