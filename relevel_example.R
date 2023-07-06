

# set up
library(tidyverse)
library(tidymodels)
bh <- readRDS('data/bh.rds')

# original data
head(bh$referred)               # Levels: bh_referred < bh_not_referred
head(bh$su_screening_train)     # Levels: Unchecked Checked
bh |>
  glm(referred ~ su_screening_train, family = 'binomial', data = _) |>
  tidy(exponentiate = TRUE)     # OR=0.272 -- BAD JUJU



# This is BAD...
# relevel the outcome variable -- First attempt... only fct_relevel(referred)
bh_redone1 <-
  bh |>
  mutate(
    referred = fct_relevel(referred, 'bh_referred'),
  )
head(bh_redone1$referred)               # Levels: bh_referred < bh_not_referred
head(bh_redone1$su_screening_train)     # Levels: Unchecked Checked
bh_redone1 |>
  glm(referred ~ su_screening_train, family = 'binomial', data = _) |>
  tidy(exponentiate = TRUE)             # OR=0.272
## NOTHING CHANGED!!!



## This is GOOD...
# relevel the outcome variable -- Second attempt... fct_relevel() referred & training
bh_redone2 <-
  bh |>
  mutate(
    referred = fct_relevel(referred, 'bh_referred'),
    su_screening_train = fct_relevel(su_screening_train, 'Checked')
  )

head(bh_redone2$referred)               # Levels: bh_referred < bh_not_referred
head(bh_redone2$su_screening_train)     # Levels: CHECKED Unchecked
bh_redone2 |>
  glm(referred ~ su_screening_train, family = 'binomial', data = _) |>
  tidy(exponentiate = TRUE)             # OR=3.68 -- SAME AS SAS OUTPUT!!!



## This one works too!
# do it with original data and tidymodels; WILL NOT fct_relevel(referered)!
bh_log_model <-
  logistic_reg() |>
  set_engine('glm') |>
  set_mode('classification')

head(bh$referred)                        # Levels: bh_referred < bh_not_referred
head(bh$su_screening_train)              # Levels: Unchecked Checked
is.factor(bh$su_screening_train)         # TRUE
bh_rec <-
  recipe(referred ~ su_screening_train, data = bh) |>
  step_relevel(all_factor_predictors(), ref_level = 'Checked') # correct order now

bh_log_workflow <-
  workflow() |>
  add_recipe(bh_rec) |>
  add_model(bh_log_model)

bh_log_workflow |>
  fit(data = bh) |>
  tidy(exponentiate = TRUE)              # OR=3.68 -- SAME AS SAS OUTPUT



## Not so much here. BAD output...
# do it AGAIN with original data and tidymodels; WILL fct_relevel(referered)! with Inf
bh_redone3 <-
  bh |>
  mutate(
    referred = fct_relevel(referred, 'bh_referred', after = Inf) # WRONG ORDER NOW
  )

head(bh_redone3$referred)                # Levels: bh_not_referred < bh_referred -SEE!!!!
head(bh_redone3$su_screening_train)      # Levels: Unchecked Checked
is.factor(bh$su_screening_train)         # TRUE
bh_rec_releveled <-
  recipe(referred ~ su_screening_train, data = bh_redone3) |>
  step_relevel(all_factor_predictors(), ref_level = 'Checked')

bh_log_workflow <-
  workflow() |>
  add_recipe(bh_rec_releveled) |>
  add_model(bh_log_model)

bh_log_workflow |>
  fit(data = bh_redone3) |>
  tidy(exponentiate = TRUE)               # OR=0.272 -- BAD OUTPUT


# This works too!
# do it AGAIN with original data and tidymodels; WILL fct_relevel(referered)! withOUT Inf
bh_redone4 <-
  bh |>
  mutate(
    referred = fct_relevel(referred, 'bh_referred')
  )

head(bh_redone4$referred)                  # Levels: bh_referred < bh_not_referred
head(bh_redone4$su_screening_train)        # Unchecked Checked
is.factor(bh_redone4$su_screening_train)   # TRUE
bh_rec_releveled <-
  recipe(referred ~ su_screening_train, data = bh_redone4) |>
  step_relevel(all_factor_predictors(), ref_level = 'Checked') # correct order now

bh_log_workflow <-
  workflow() |>
  add_recipe(bh_rec_releveled) |>
  add_model(bh_log_model)

bh_log_workflow |>
  fit(data = bh_redone4) |>
  tidy(exponentiate = TRUE)          # OR=3.68 -- MATCHES SAS OUTPUT




# LAST TIME with original data and tidymodels; WILL fct_relevel(training)
bh_redone5 <-
  bh |>
  mutate(
    su_screening_train = fct_relevel(su_screening_train, 'Checked')
  )

head(bh_redone5$referred)                 # bh_referred < bh_not_referred
head(bh_redone5$su_screening_train)       # Checked Unchecked
is.factor(bh_redone5$su_screening_train)  # TRUE
bh_rec_releveled <-
  recipe(referred ~ su_screening_train, data = bh_redone5) |>
  step_relevel(all_factor_predictors(), ref_level = 'Checked')

bh_log_workflow <-
  workflow() |>
  add_recipe(bh_rec_releveled) |>
  add_model(bh_log_model)

bh_log_workflow |>
  fit(data = bh_redone5) |>
  tidy(exponentiate = TRUE)          # OR=3.68 -- MATCHES SAS OUTPUT



#### Moral of the story ####
# good output to match SAS:
# (1) put the predictor level that triggers the event first: CHECKED then Unchecked
# (2) outcome event ALSO needs to be placed first in order: Referred then NOT referred
# (3) DO NOT USE after = Inf option for the outcome event!! it will model the wrong thing
#############################



