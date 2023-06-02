# calculate 95%CIs for Pearson's
#
# place var1 & var2 in quotes: r_ci(dataset, 'var1', 'var2')
r_ci <- function(dsn, var1, var2, method = 'pearson') {
  # dsn = dataset name
  # var1 = first variable
  # var2 = second variable
  n=nrow(dsn)
  # calculate Pearson's r and remove NA values
  r=cor(dsn[var1], dsn[var2], method = method,
        use = 'pairwise.complete.obs')
  # calculate for 95%CIs using Fisher's transformation
  z=0.5 * (log((1+r)/(1-r)))
  SEr=sqrt(1/(n-3))
  limit_1=z-(1.96*SEr)
  limit_2=z+(1.96*SEr)
  # back transform to obtain final 95%CIs
  limit_lower=(exp(2*limit_1)-1)/(exp(2*limit_1)+1)
  limit_upper=(exp(2*limit_2)-1)/(exp(2*limit_2)+1)
  # display results in the console
  print(sprintf('N: %0.0f', n))
  print(sprintf("Pearson's r: %0.3f", r))
  print(sprintf('LCL: %0.3f', limit_lower))
  print(sprintf('UCL: %0.3f', limit_upper))
}

