




# Week 3 Quiz -------------------------------------------------------------
library(datasets)

iris <- iris
mtcars <- mtcars

#1
tapply(iris$Sepal.Length, iris$Species, mean)

#2
apply(iris[,1:4], 2, mean)

#3
with(mtcars, tapply(mpg, cyl, mean))
sapply(split(mtcars$mpg, mtcars$cyl), mean)
tapply(mtcars$mpg, mtcars$cyl, mean)

#4 
with(mtcars, tapply(hp, cyl, mean))
209.21429 - 82.63636

#5
