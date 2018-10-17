library(tidyverse)

# Refer to the data for 1050 subjects with cerebral edema (CEREBRAL). Cerebral edema with
#consequent increased intracranial pressure frequently accompanies lesions resulting from head
#injury and other conditions that adversely affect the integrity of the brain. 
#Available treatments for cerebral edema vary in effectiveness and undesirable side effects. 
#One such treatment is glycerol,
#administered either orally or intravenously. Of interest to clinicians is the relationship between
#intracranial pressure and glycerol plasma concentration. Suppose you are a statistical consultant
#with a research team investigating the relationship between these two variables. Select a simple
#random sample from the population and perform the analysis that you think would be useful to the
#researchers. Present your findings and conclusions in narrative form and illustrate with graphs
#where appropriate. Compare your results with those of your classmates.

#Reading data and changing its name
cereb <- read_csv("data_daniels/ch09_all/LDS_C09_CEREBRAL.csv")
names(cereb) <- c("sub", "glyc", "icp")

#Resampling data 

#50subs
cereb_50 <- sample_n(cereb, 50)

ggplot(data = mod_cereb_50, mapping = aes(x = glyc, y = icp)) + geom_point(na.rm = TRUE) + 
    geom_smooth(method = "lm", se = FALSE, colour = "red")+ 
    geom_jitter(height = 0.03, width = 0.03)

mod_cereb_50 <- lm(icp ~ glyc, data = cereb_50)
summary(mod_cereb_50)
par(mfrow=c(2,2))
plot(mod_cereb_50)

#100subs
cereb_100 <- sample_n(cereb, 100)

ggplot(data = mod_cereb_100, mapping = aes(x = glyc, y = icp)) + geom_point(na.rm = TRUE) + 
    geom_smooth(method = "lm", se = FALSE, colour = "red")+ 
    geom_jitter(height = 0.03, width = 0.03)


mod_cereb_100 <- lm(icp ~ glyc, data = cereb_100)
summary(mod_cereb_100)
par(mfrow=c(2,2))
plot(mod_cereb_100)


#250subs
cereb_250 <- sample_n(cereb, 250)

ggplot(data = mod_cereb_250, mapping = aes(x = glyc, y = icp)) + geom_point(na.rm = TRUE) + 
    geom_smooth(method = "lm", se = FALSE, colour = "red")+ 
    geom_jitter(height = 0.03, width = 0.03)

mod_cereb_250 <- lm(icp ~ glyc, data = cereb_250)
summary(mod_cereb_250)
par(mfrow=c(2,2))
plot(mod_cereb_250)


