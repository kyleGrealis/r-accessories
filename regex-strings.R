text <- '9675 Happy Dr.\nAnywhere, TX 12345\nGet Directions'
writeLines(text)

library(stringr)
library(tidyverse)

# 9675
str_extract(text, '^[0-9]+')

# 9675 Happy
str_extract(text, '^[0-9]+\\s\\w+')

# 9675 Happy Dr
str_extract(text, '^[0-9]+\\s\\w+\\s\\w+')


str_extract(text, '\\,$')

