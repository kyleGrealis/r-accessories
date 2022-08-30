# -------------------------------------------------------
# run this first:
usethis::edit_r_profile()

# -------------------------------------------------------
# copy and paste all of this into the .Rprofile:
if (interactive()) {
  suppressMessages(require(devtools))
  suppressMessages(require(usethis))
}

options(
  usethis.full_name = "Kyle Grealis",
  usethis.description = list(
    `Authors@R` = 'person(
    given = "Kyle", family = "Grealis",
    role = c("aut", "cre"),
    email = "kxg679@miami.edu",
    comment = c(ORCID = "0000-0002-9223-8854"))'
  )
)

