###########################
#                         #
#    Assignment Week 3    #
#                         # 
###########################

# Instructions ####
# Fill in this script with stuff that we do in class.
# It might be a good idea to include comments/notes as well so you remember things we talk about
# At the end of this script are some comments with blank space after them
# They are plain-text instructions for what you need to accomplish.
# Your task is to write the code that accomplished those tasks.

# Then, make sure to upload this to both Canvas and your GitHub repository




# Vector operations! ####

# Vectors are 1-dimensional series of values in some order
1:10 # ':' only works for integers
letters # built-in pre-made vector of a - z



vector1 <- c(1,2,3,4,5,6,7,8,9,10) # adds vector to the environment
vector1 <- 1:10 # does same thing as above
vector2 <- c(5,6,7,8,4,3,2,1,3,10) # concatenates numbers into a vector that are not sequential
vector3 <- letters # letters and LETTERS are built-in vectors

vector1 + 5 # adds 5 to each value in vector1
vector2 / 2 # divides each value in vector2 by 2
vector1*vector2 # multiplies the numbers in the vectors by each other, sequentially

vector3 + 1 # can't add 1 to "a"


# Logical expressions (pay attention to these...they are used ALL THE TIME)
vector1 > 3 # checks each value in vector1 to see if it's greater than 3, only true for numbers above 3
vector1 >= 3 # checks each value in vector1 to see if it's greater than or equal to 3
vector1 < 5 # checks each value in vector1 to see if it's less than 5
vector1 <= 5 # checks which values are greater than or equal to 5
vector1 == 7 # which values are exactly equal to 7
letters == "a" # checks whether each letter is a, only true for the first one
letters != "c" # checks whether each letter is not c
letters %in% c("a","b","c","z") # checks for these letters inside the group
vector1 %in% 1:6 # checks for which values between 1 and 6 are in the vector


# Data Frames ####
# R has quite a few built-in data sets
data("iris") # load it like this

# For built-in data, there's often a 'help file'
?iris

# "Iris" is a 'data frame.' 
# Data frames are 2-dimensional (think Excel spreadsheet)
# Rows and columns
# Each row or column is a vector


dat <- iris # can rename the object to be easier to type if you want

# ways to get a peek at our data set
names(dat) # shows column names
dim(dat) # gives number of rows and columns
head(dat) # shows the first 6 rows of data frame


# You can access specific columns of a "data frame" by name using '$'
dat$Species
dat$Sepal.Length

# You can also use square brackets to get specific 1-D or 2-D subsets of a data frame (rows and/or columns)
dat[1,1] # [Rows, Columns]
dat[1:3,5] # rows 1-3, column 5

vector2[1] # gives first value in vector2
letters[1:7] # gives first seven letters
letters[c(1,3,5,7)] # gives letters at these specific positions


# Plotting ####

# Can make a quick plot....just give vectors for x and y axes
plot(x=dat$Petal.Length, y=dat$Sepal.Length) # x axis is petal length, y axis is sepal length
plot(x=dat$Species, y=dat$Sepal.Length) # shows as boxplot because now x axis is a factor, not a number


# Object "Classes" ####

#check the classes of these vectors
class(dat$Petal.Length) # tells us this vector contains numeric data
class(dat$Species) # tells us this vector contains factor data

# plot() function behaves differently depending on classes of objects given to it!

# Check all classes (for each column in dat)
str(dat) # shows column names, sample values, class of each column

# "Classes" of vectors can be changed if needed (you'll need to, for sure, at some point!)

# Let's try
nums <- c(1,1,2,2,2,2,3,3,3,4,4,4,4,4,4,4,5,6,7,8,9) # adds vector called nums to environment
class(nums) # make sure it's numeric (checks class of vector named nums)

# convert to a factor
as.factor(nums) # show in console
nums_factor <- as.factor(nums) #assign it to a new object as a factor
class(nums_factor) # check it


# convert numeric to character
as.character(vector1)
as.character(vector1) + 5 # doesn't work because we just changed vector1 to characters

# convert character to numeric
as.numeric(vector3) # commands to turn letters to numeric values, but returns NA because it can't do that




#check it out
plot(nums) # dot plot
plot(nums_factor) # bar graph
# take note of how numeric vectors and factors behave differently in plot()




# Simple numeric functions
# R is a language built for data analysis and statistics so there is a lot of functionality built-in

max(vector1)
min(vector1)
median(vector1)
mean(vector1)
range(vector1)
summary(vector1) # gave all values for 5 number summary

# cumulative functions
cumsum(vector1) # adds each number in the vector like 1, 1+2, 1+2+3 etc.
cumprod(vector1) # same as above but with multiplication
cummin(vector1) # smallest value in each of the above calculations
cummax(vector1) # largest number in each of the above calculations

# even has built-in statistical distributions (we will see more of these later)
dbinom(50,100,.5) # probability of getting exactly 50 heads out of 100 coin flips




# YOUR REMAINING HOMEWORK ASSIGNMENT (Fill in with code) ####

# 1.  Get a subset of the "iris" data frame where it's just even-numbered rows

seq(2,150,2) # here's the code to get a list of the even numbers between 2 and 150

iris[seq(2,150,2), ] ## shows even numbered rows from iris dataset for all columns
iris_even <- iris[seq(2,150,2), ] ## stores in environment

# 2.  Create a new object called iris_chr which is a copy of iris, except where every column is a character class

str(iris)
iris_chr <- as.data.frame(lapply(iris, as.character))
str(iris_chr)

# 3.  Create a new numeric vector object named "Sepal.Area" which is the product of Sepal.Length and Sepal.Width

head(iris$Sepal.Length)
head(iris$Sepal.Width)
Sepal.Area <- iris$Sepal.Length * iris$Sepal.Width
head(Sepal.Area)
5.1 * 3.5 ## checking the first value in each column to confirm it worked

# 4.  Add Sepal.Area to the iris data frame as a new column

iris$Sepal.Area <- Sepal.Area
head(iris)

# 5.  Create a new dataframe that is a subset of iris using only rows where Sepal.Area is greater than 20 
      # (name it big_area_iris)

iris$Sepal.Area > 20
iris[iris$Sepal.Area > 20, ]
big_area_iris <- iris[iris$Sepal.Area > 20, ]
head(big_area_iris)
dim(big_area_iris)

# 6.  Upload the last numbered section of this R script (with all answers filled in and tasks completed) 
      # to canvas
      # I should be able to run your R script and get all the right objects generated

