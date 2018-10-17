library(tidyverse)
library(car)

#read file
bmd_dx <- read_csv(file = "data_daniels/ch08_all/EXR_C08_S02_02.csv")

#setting names and factors
names(bmd_dx) <- c("bmd", "dx")
bmd_dx$dx <- factor(bmd_dx$dx)
levels(bmd_dx$dx) <- c("RA", "LUPUS", "PMRTA", "OA", "O")

#Homoscedasticity and normality tests
by(bmd_dx$bmd, bmd_dx$dx, shapiro.test)
bartlett.test(bmd ~ dx, bmd_dx)
leveneTest(bmd ~ dx, bmd_dx)

#ANOVA
bmd_mod <- aov(bmd ~ dx, bmd_dx)

#Plots
par(mfrow = c(2, 2))
plot(bmd_mod)
bmd_plot <- ggplot(bmd_dx, aes(bmd)) + 
    theme_minimal(base_size = 13)

bmd_plot + 
    geom_dotplot(binwidth = 1.5) + 
    scale_y_continuous(name = "count", breaks = NULL) + 
    facet_grid(. ~ dx)

bmd_plot + 
    geom_boxplot(aes(dx, bmd)) +
    xlab("dx")

#Results of ANOVA
summary(bmd_mod)

#Tukey
TukeyHSD(bmd_mod)
plot(TukeyHSD(bmd_mod))
