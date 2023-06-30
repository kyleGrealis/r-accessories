load('../rtt/data/RTT_data.RData')

dat1 <-
  rtt_prep |> 
  select(
   record_id, organization, total_tested,
   cat_var = client_didnt_think_could_pay,
   num_var = prep_self_eff,
   outcome_yes = prep_referred, 
   outcome_no = prep_not_referred
  ) |> 
  mutate_if(is.character, .funs = factor)

skimr::skim(dat1)

# no change to reference levels
levels(dat1$cat_var) # no yes

glm(
  cbind(outcome_yes, outcome_no) ~ cat_var + num_var,
  family = binomial(),
  data = dat1
)

glm(
  outcome_yes/total_tested ~ cat_var + num_var,
  family = binomial(),
  weights = total_tested,
  data = dat1
)




# changing ref level for cat_var
dat2 <-
  dat1 |> 
  mutate(
    cat_var = relevel(cat_var, ref = 'No')
  )

levels(dat1$cat_var) # no yes
levels(dat2$cat_var) # no yes

glm(
  cbind(outcome_yes, outcome_no) ~ cat_var + num_var,
  family = binomial(),
  data = dat2
)

glm(
  outcome_yes/total_tested ~ cat_var + num_var,
  family = binomial(),
  weights = total_tested,
  data = dat2
)


################ THIS METHOD DOES NOT MATCH IN SAS ############################
# changing ref level for cat_var
dat3 <-
  dat1 |> 
  mutate(
    cat_var = relevel(cat_var, ref = 'Yes')
  )

levels(dat1$cat_var) # no yes
levels(dat2$cat_var) # no yes
levels(dat3$cat_var) # yes no !!!!!!!!!

glm(
  cbind(outcome_yes, outcome_no) ~ cat_var + num_var,
  family = binomial(),
  data = dat3
)

glm(
  outcome_yes/total_tested ~ cat_var + num_var,
  family = binomial(),
  weights = total_tested,
  data = dat3
)
###############################################################################




# pivot data
dat4 <-
  dat1 |> 
  pivot_longer(
    cols = c(outcome_no, outcome_yes),
    values_to = 'n',
    names_to = 'outcome'
  ) |> 
  mutate(
    outcome = factor(str_remove(outcome, 'outcome_'))
  ) |> 
  uncount(n)

levels(dat4$outcome) # no yes
levels(dat4$cat_var) # no yes

glm(
  outcome ~ cat_var + num_var,
  family = binomial(),
  data = dat4
)





dat5 <-
  dat4 |> 
  mutate(
    outcome = relevel(outcome, ref = 'no')
  )

levels(dat5$cat_var) # no yes
levels(dat5$outcome) # no yes

glm(
  outcome ~ cat_var + num_var,
  family = binomial(),
  data = dat5
)




dat6 <-
  dat4 |> 
  mutate(
    outcome = relevel(outcome, ref = 'no'),
    cat_var = relevel(cat_var, ref = 'No')
  )

levels(dat6$cat_var) # no yes
levels(dat6$outcome) # no yes

glm(
  outcome ~ cat_var + num_var,
  family = binomial(),
  data = dat6
)




################ THIS METHOD DOES NOT MATCH IN SAS ############################
dat7 <-
  dat4 |> 
  mutate(
    outcome = relevel(outcome, ref = 'no'),
    cat_var = relevel(cat_var, ref = 'Yes')
  )

levels(dat7$cat_var) # yes no
levels(dat7$outcome) # no yes

glm(
  outcome ~ cat_var + num_var,
  family = binomial(),
  data = dat7
)
###############################################################################


# backwards from what is originally entered, but matches
dat8 <-
  dat4 |> 
  mutate(
    outcome = relevel(outcome, ref = 'yes'),
    cat_var = relevel(cat_var, ref = 'No')
  )

levels(dat8$cat_var) # no yes
levels(dat8$outcome) # yes no

glm(
  outcome ~ cat_var + num_var,
  family = binomial(),
  data = dat8
)



################ THIS METHOD DOES NOT MATCH IN SAS ############################
dat9 <-
  dat4 |> 
  mutate(
    outcome = relevel(outcome, ref = 'yes'),
    cat_var = relevel(cat_var, ref = 'Yes')
  )

levels(dat9$cat_var) # yes no
levels(dat9$outcome) # yes no

glm(
  outcome ~ cat_var + num_var,
  family = binomial(),
  data = dat9
)
###############################################################################
