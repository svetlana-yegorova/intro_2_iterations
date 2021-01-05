# 12/4/21
# practice looping exercises: 

library(tidyverse)

# components of a loop: 
# 1. output structure
# 2. the sequence over which to iterate
# 3. the body

# simple loop example: 

df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

output <- vector("double", ncol(df))  # 1. output
for (i in seq_along(df)) {            # 2. sequence, can use 1:ncol(df) as well. 
  output[[i]] <- median(df[[i]])      # 3. body
}
output
#> [1] -0.24576245 -0.28730721 -0.05669771  0.14426335


# Exercise 1. Write for loops to:
#   
# 1. Compute the mean of every column in mtcars.
# 2. Determine the type of each column in nycflights13::flights.
# 3. Compute the number of unique values in each column of iris.
# 4. Generate 10 random normals from distributions with means of -10, 0, 10, and 100.
# Think about the output, sequence, and body before you start writing the loop.



# Exercise 2. 
# It’s common to see for loops that don’t preallocate the output and instead 
# increase the length of a vector at each step:

output <- vector("integer", 0)
for (i in seq_along(x)) {
  output <- c(output, lengths(x[[i]]))
}
output

# How does this affect performance? Design and execute an experiment.