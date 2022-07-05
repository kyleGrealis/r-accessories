# set up including p-values and strata %

pvalue <- function(x, ...) {
  # Construct vectors of data y, and groups (strata) g
  y <- unlist(x)
  g <- factor(rep(1:length(x), times=sapply(x, length)))
  if (is.numeric(y)) {
    # For numeric variables, perform ANOVA
    p <- unlist(summary(aov(y ~ g, data = workable_geco)))[9]
  } else {
    # For categorical variables, perform a chi-squared test of independence
    p <- round(chisq.test(table(y, g))$p.value, digits = 3)
  }
  # Format the p-value, using an HTML entity for the less-than sign.
  # The initial empty string places the output on the line below the variable label.
  c("", sub("<", "&lt;", format.pval(p, digits=3, eps=0.001)))
}

# function to add percentage to table header row
render.strat <- function (label, n, ...) {
  overall.n <- sum(as.numeric(n)[names(n)!="overall"], na.rm = TRUE)
  pct <- 100*as.numeric(n)/overall.n
  pct <- round_pad(pct, 0)
  sprintf(
    ifelse(
      is.na(n),
      "<span class='stratlabel'>%s</span>",
      "<span class='stratlabel'>%s<br><span class='stratn'>(N=%s; %s%%)</span></span>"
    ),
    label, n, pct)
}
