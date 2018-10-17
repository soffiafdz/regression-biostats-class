#hw9.7.4

#Problem 9.7.4 
#An article by Tuzson et al. (A-9) in Archives of Physical Medicine and Rehabilitation reported the following data on peak knee velocity in walking (measured in degrees per second) at flexion and extension for 18 subjects with cerebral palsy.
#Prepare a scatter diagram
#Compute the sample correlation coefficcient
#Test H0: p = 0 at the .05 level of significance and state your conclusion
#Determine the p value for the test
#Construct the 95 percent confidence interval for p. 


#Read data 
knee_vel <- readr::read_csv(file = "data_daniels/ch09_all/EXR_C09_S07_04.csv")

#Scatter plot
plot(knee_vel)

require(ggplot2)
theme_set(theme_bw())
ggplot(knee_vel, aes(FLEX, EXT)) + 
    geom_point() + 
    geom_smooth(method = "lm", se = F, colour = 'black') +
    geom_vline(aes(xintercept = mean(FLEX)), 
               colour = "gray", linetype = "dashed") + 
    geom_hline(aes(yintercept = mean(EXT)),
               colour = "gray", linetype = "dashed")


#Computation 
result <- cor.test(~ EXT + FLEX, data = knee_vel)

#Correlation coefficient
result$estimate

#Test H0 : rho = 0 at the 0.5 level of significance
result$statistic

#Determine the p value for the test
result$p.value

#Construct the 95 percent confidence interval for rho
result$conf.int