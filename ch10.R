#Chapter 10 Multiple Regression and Correlation

##Obtain the regression equation for each of the following datasets

###10.3.3
###In a study of factors thought to be related to patterns of admission to a large general hospital, an administrator obtained these data on 10 communities in the hospital’s catchment area:
####c("Y - Persons per 1000 admitted", "X1 - Index health services", "X2 - Index indigency")

ex10_3_3 <- readr::read_csv("data_daniels/ch10_all/ch10_all/EXR_C10_S03_03.csv")

my_line <- function(x,y,...){
    points(x,y,...)
    abline(lm(y ~ x))
}

pairs(ex10_3_3, lower.panel = my_line, upper.panel = NULL)

lm(Y ~ X1 + X2, data = ex10_3_3)
summary(lm(Y ~ X1 + X2, data = ex10_3_3))

#Equation: Yj = 13.45 + 4.02x1j + 2.81x2j

###10.3.5
###A random sample of 25 nurses selected from a state registry yielded the following information on each nurse’s score on the state board examination and his or her final score in school. Both scores relate to the nurse’s area of affiliation. Additional information on the score made by each nurse on an aptitude test, taken at the time of entering nursing school, was made available to the researcher. The complete data are as follows:
#### State board score, Final score, Aptitude Score

ex10_3_5 <- readr::read_csv("data_daniels/ch10_all/ch10_all/EXR_C10_S03_05.csv")
    
ex10_3_5

pairs(ex10_3_5, lower.panel = my_line, upper.panel = NULL)

lm(Y ~ X1 + X2, data = ex10_3_5)
summary(lm(Y ~ X1 + X2, data = ex10_3_5))

#Equation: Yj = -422 + 11.17x1j - 0.63x2j


###10.8
###In a study of the relationship between creatinine excretion, height, and weight, the data shown in the following table were collected on 20 infant males:
####Infant, creatinine, weight, height

ex10_8 <- readr::read_csv("data_daniels/ch10_all/ch10_all/REV_C10_08.csv")
ex10_8

pairs(ex10_8[-1], lower.panel = my_line, upper.panel = NULL)

lm(CREATIN ~ WEIGHT + HEIGHT, data = ex10_8)

#Equation Yj = 23.193 + 17.55x1j - 1.11x2j
mod <- lm(CREATIN ~ WEIGHT + HEIGHT, data = ex10_8)

summary(mod)

newdata <- data.frame(WEIGHT = 10, HEIGHT = 60)
predict(mod, newdata)
###Find the multiple regression equation describing the relationship among these variables.
###Compute R2 and do an analysis of variance.
###Let X 1= 10 and X2= 60 and find the predicted value of Y.

    