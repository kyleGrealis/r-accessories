#
# By: Kyle Grealis
# Creating GitHub PAT
#
# Created: Sunday, May 15, 2022 at 16:51:18
#
# -------------------------------------------------------
# 
# Load packages
library(gitcreds)

# -------------------------------------------------------
# obtain token
usethis::create_github_token()
gitcreds_set()