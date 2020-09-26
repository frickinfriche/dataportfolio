## Nikita Friche, PID: A15628097

## Econ/Poli 5 Lecture 5
## Introducing basic operations in R & Subsetting Data


## Submit the completed R-script online as your first participation quiz. Write your name and PID on the top of the script.
## Save it as LastName_FirstName.R

## Arithmetic Operations
5+3
5/3
5^3

## Assigning values
object_1 <- 5+3
object_1
print(object_1)
## Class of a variable
class(object_1)

## Overwriting values
object_1 <- 5-3
object_1
print(object_1)

## Creating string values
MySchool <- "UCSD"
MySchool
class(MySchool)

## Creating vectors
vector.1 <- c(93,92,83,99,96,97)
vector.1
class(vector.1)

## Indexing
vector.1[3]

vector.1[c(1,3,4)]

## removing elements of a vector
vector.1[-3]

## Vector operations
vector.1*100

vec1 <- c(1,2,3)
vec2 <- c(3,3,3)

vec1 +vec2

vec1*vec2

vec1/vec2

## Functions
length(vector.1)
min(vector.1)
max(vector.1)
range(vector.1)
mean(vector.1)
sum(vector.1)


## Working with data
getwd()
  
setwd("[Your Computer Directory Here]")
getwd()

load("[The Path to Your Resume File as RData Here")

resume <- read.csv("resume.csv")

## Basic summary statistics with data
names(resume)
nrow(resume)
ncol(resume)
dim(resume)
summary(resume)
head(resume)
tail(resume)


## Subsetting data
resume[1:3, "firstname"]

resume[1:3, 2]

head(resume$firstname, 4)

## Saving Data

write.csv(resume, file= "resume.csv")

save(resume, file= "resume.RData")

## Exercises

#================================================================================#
## 1. Run the folowing commands and write the output as comment in this R-script
#================================================================================#

#a. paste command is used for joining string values.
paste("2+2=", 2+2 )
# "2+2= 4"

#b. Equal to sign is another way to assign values to objects.
instructor= "Greg"
paste("The instructor of this class is", instructor)
# "The instructor of this class is Greg"

#================================================================================#
## 2. You can treat a variable in a dataset as vector and 
##     run all the vector functions we learnt in this class on it.
#================================================================================#


#a. 
max(resume$call)
## 1
min(resume$call)
## 0
range(resume$X)
## 1, 4870

#b. Calculate the mean of the variable X in dataset resume. Give both the command and the output.
mean(resume$X)
# 2435.5

#c. How many people received a call in the dataset resume?
##  Give both the command and the output.
sum(resume$call)
# 392


#================================================================================#
## 3. Suppose the dimensions of a dataset are 300 X 4. Let school be one of the 
##    variables in this dataset. Then what would be the output of the command
##    length(dataset$school)?
#================================================================================#

#  300

## Part II

# Tips:
# Remember to use help() if you cannot remember how a function works,
#     for example, help("mean")

#1: classes
# Create a vector containing a number and a string. What is its class?
vec.1 <- c(1, "string")
class(vec.1)

# What is the class of the empty string, "" ? 
class("")

# What is the class of the empty vector, c() ? 
class(c())

#2: more classes
a <- c(0.5, 1.75, 2.15)
# There's a command: as.integer(). 
# What happens if you apply it to a vector "a", which contains decimals?
as.integer(a)

# What is the class of a?
class(a)

# Overwrite the third element of "a" as a text string (character).
a[3] <- "2.15"

# What is the class of a now?
class(a)
a

# Now make the third element of "a" a number again. What is the class of a now?
a[3] <- 2.15
class(a)
a

#3: logicals
logic1 = c(TRUE, TRUE, FALSE, TRUE)
logic2 = c(TRUE, FALSE, FALSE, FALSE)
# a) Evaluate logic1 | logic2 
logic1 | logic2

# b) Evaluate logic1 & logic2 
logic1 & logic2

# What do TRUE and FALSE translate into for integers?
as.integer(TRUE)
as.integer(FALSE)

# Is TRUE > FALSE? Why or why not? (hint: coercion)
TRUE > FALSE

# Coerce a) and b) to integers, sum, and take the difference, that is
#   compute sum(a) - sum(b). (hint: use as.integer())
logic.a <- logic1 | logic2
logic.b <- logic1 & logic2
sum(logic.a) - sum(logic.b)
# or
as.integer(logic.a)
as.integer(logic.b)

# Is 5 < "a" ? Is 5 < "5" ? Why?
5 < "a"
5 < "5"
# R interprets these as "5" < "a" and 5 < 5, respectively, via coercion.
# Within the character class, > checks alphabetical order with preference
# given first to capitalized letters, then lowercase letters, then numbers, so
# "A" > "Z" and "Z" > "a" and "a" > "z" and "z" > "9" and "9" > "0".

#4: subsetting
resume <- read.csv("resume.csv")
# Use summary() to explore the data. How many variables are there?
summary(resume)
# There are four variables (note that "X" is an ID)

# Generate a table using table() of resume$race vs resume$call - 
#     first row should have 2278 157. 
# Add margins to the table with the addmargins() function.
table.1 <- table(resume$race, resume$call)
table.1
table.1 <- addmargins(table.1)
table.1

# Calculate the mean call rates for blacks and whites using mean() and
#     logical operators. (hint: use [] to subset data.)
mean(resume$call[resume$race == "black"])
mean(resume$call[resume$race == "white"])

# Create a subset of the resume dataframe using subset() that is the
#     names and calls for only the white females. Do the same
#     for black females. You should have 1860 white females and 
#     1886 black females. (hint: use dim() to get size of dataframes.)
WhiteFemale <- subset(resume, resume$race == "white" & resume$sex == "female", 
                      select = c("firstname", "call"))
dim(WhiteFemale)
BlackFemale <- subset(resume, resume$race == "black" & resume$sex == "female", 
                      select = c("firstname", "call"))
dim(BlackFemale)

# Use mean() to compare the call rates for white and black females. You 
#     should find a difference of 0.3264.
mean(WhiteFemale$call) - mean(BlackFemale$call)

# If time, complete the same calculations for white/black males.
WhiteMale <- subset(resume, resume$race == "white" & resume$sex == "male", 
                    select = c("firstname", "call"))
BlackMale <- subset(resume, resume$race == "black" & resume$sex == "male", 
                    select = c("firstname", "call"))
mean(WhiteMale$call) - mean(BlackMale$call)


