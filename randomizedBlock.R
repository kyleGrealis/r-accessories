rm(list = ls())

set.seed(123)
blocksize = 4
N = 44
block = rep(1:ceiling(N/blocksize), each = blocksize)
a1 = data.frame(block, rand = runif(length(block)), envelope = 1:length(block))
a2 = a1[order(a1$block, a1$rand), ]
a2$arm = rep(c("0", "1"), times = length(block)/2)
assign = a2[order(a2$envelope), ]

assign = tibble(id = seq(1:N, by = 1), assign$arm)
assign
