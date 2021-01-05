# 12/4/21
# practice looping exercises and content borrowed from "R for Data Science" 
# by H. Wickham and G. Grolemund
# more info can be found here: https://r4ds.had.co.nz/iteration.html

library(tidyverse)

# components of a loop: 
# 1. output structure
# 2. the sequence over which to iterate
# 3. the body

# simple loop example: 

# data:
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

median(df$a)

# start.time<-Sys.time()

output <- vector("double", ncol(df))  # 1. output

for (i in seq_along(df)) {            # 2. sequence, can use 1:ncol(df) as well. 
  output[[i]] <- median(df[[i]])      # 3. body
}
# end.time<-Sys.time()
# write.time<-end.time-start.time

output

##### Inefficient alternative to pre-setting the output structure #####
##### Takes quite a bit longer, important to understand the difference: 
# start.time<-Sys.time()

output<-vector("double", 0)
for (i in seq_along(df)) {                # 2. sequence, can use 1:ncol(df) as well. 
    output <- c(output, median(df[[i]]))  #3. body
}
 
# end.time<-Sys.time()
# combine.time<-end.time-start.time
output

##### Difference between using 1:n and seq_along() #####
y <- vector("double", 0)
seq_along(y)
#> integer(0)
1:length(y)
#> [1] 1 0





# Exercise 1. Write for loops to:
# 10-15 minutes.
#   
# 1. Compute the mean of every column in mtcars.
# 2. Determine the type of each column in nycflights13::flights (may need to install.packages("nycflights13").
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


##### Dealing with unknown length of output #####


# slow way to deal with unknown output lengths: 
means <- c(0, 1, 2)

output <- double()           # set up an empty vector.
for (i in seq_along(means)) {
  n <- sample(100, 1)        # pick a random number n
  output <- c(output, rnorm(n, means[[i]])) # remember, using c() instead of writing
                                            # takes a lot longer (5 times longer in
                                            # the above example)
}
str(output)


# fast way to deal with unknown output lengths: 

means <- c(0, 1, 2)

out <- vector("list", length(means)) # create a vector of lists, each list 
for (i in seq_along(means)) {        # can be of different length
  n <- sample(100, 1)
  out[[i]] <- rnorm(n, means[[i]])
}
str(out)

# combine lists into a single entity
str(unlist(out))


##### Loops vs Functionals #####
# 1. solve your problem for a single element
# 2. write a function performing #1, if needed
# 3. use an iterating function instead of a for() loop to iterate over a list of 
# elements. 

# Advantages: 
# less typing = fewer opportunities for bugs. 

# apply() family: 
x <- list(
  c(0.27, 0.37, 0.57, 0.91, 0.20),
  c(0.90, 0.94, 0.66, 0.63, 0.06), 
  c(0.21, 0.18, 0.69, 0.38, 0.77)
)

threshold <- function(x, cutoff = 0.8) x[x > cutoff]

x%>%lapply(threshold) # lapply takes a list and a function as its arguments
                      # returns a list. can take additional arguments. 

# variations apply(), sapply(), vapply()



# map() function family, similar to apply family, but better
# faster implementation
# more control over output
# has useful shortcuts


 

#map(data, function)     #makes a list.
map_lgl() #makes a logical vector.
map_int() #makes an integer vector.
map_dbl() #makes a double vector.
map_chr() #makes a character vector.

# Examples of simple use: 
df

map_dbl(df, mean)
map_dbl(df, sd)

# Shortcut example. Run several linear models, subsetting the mtcars data 
# by cylinder size: 
head(mtcars)

models <- mtcars %>% 
  split(.$cyl) %>% 
  map(function(df) lm(mpg ~ wt, data = df))

# get R^2 for the three linear models: 
models %>% 
  map(summary) %>% 
  map_dbl(~.$r.squared)

# 
# Exercise 3. 
# 
# Write code that uses one of the map functions to:
# 1. Compute the mean of every column in mtcars.
# 2. Determine the type of each column in nycflights13::flights.
# 3. Compute the number of unique values in each column of iris.
# 4. Generate 10 random normals from distributions with means of -10, 0, 10, and 100.
# 
# How can you create a single vector that for each column in a data frame 
# indicates whether or not it’s a factor?
#   
  
