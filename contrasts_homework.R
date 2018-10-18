#Loading packages
pacman::p_load(car, lsmeans, emmeans, multcomp, tidyverse)

#Loading data
hers <- read_csv("hersdata.csv")

#Filtering just women without diabetes
hers_nodi <- filter(hers, diabetes == "no")

#Ordering physact variable
physact_levels <- c("much less active",
                    "somewhat less active",
                    "about as active",
                    "somewhat more active",
                    "much more active")

hers_nodi <- mutate(hers_nodi, physact = ordered(physact, levels = physact_levels))

#Plot
ggplot(hers_nodi, aes(physact, glucose)) + 
    geom_boxplot(na.rm = TRUE)

#LM model
glucose_fit_act <- lm(glucose ~ physact, data = hers_nodi)

Anova(glucose_fit_act, type="II")
summary(glucose_fit_act)
layout(matrix(1:4, nrow = 2))
plot(glucose_fit_act)


glucose_lstsqr <- emmeans(glucose_fit_act, "physact")
glucose_lstsqr

# Contrasts
Contrasts_glu = list(MAvsLA          = c(-1, -1,  0,  1,  1),
                     InteractMuchSo  = c( 1, -1,  0, -1,  1),
                     MAvsLAforMuch   = c(-1,  0,  0,  0,  1),
                     MAvsLAforSome   = c( 0, -1,  0,  1,  0),
                     phyActvsControl = c( 1,  1, -4,  1,  1),
                     MLAvsC          = c( 1,  0, -1,  0,  0),
                     MMAvsC          = c( 0,  0, -1,  0,  1),
                     SLAvsC          = c( 0,  1, -1,  0,  0),
                     SMAvsC          = c( 0,  0, -1,  1,  0))
contrast(glucose_lstsqr, Contrasts_glu, adjust="sidak")

#Null
contrast(glucose_lstsqr, Contrasts_glu, adjust="none")
contrast(glucose_lstsqr, Contrasts_glu, adjust="bonferroni")

# Same cotrasts with multicomp library
Input = ("
Contrast.Name     AAA   MLA  MMA  SLA  SMA
 MAvsLA             0   -1    1   -1    1
 InteractMuchSo     0    1    1   -1   -1
 MAvsLAforMuch      0   -1    1    0    0
 MAvsLAforSome      0    0    0   -1    1
 phyActvsControl   -4    1    1    1    1
 MLAvsC            -1    1    0    0    0
 MMAvsC            -1    0    1    0    0
 SLAvsC            -1    0    0    1    0
 SMAvsC            -1    0    0    0    1
")
Cont_glucose_Matriz = as.matrix(read.table(textConnection(Input), header=TRUE, row.names=1))
Cont_glucose_Matriz
G = glht(glucose_fit_act, linfct = mcp(physact = Cont_glucose_Matriz))
G$linfct
summary(G, test=adjusted("single-step"))


# From https://rcompanion.org/rcompanion/h_01.html
# 
# Example from R companion: Contrasts in Linear Models
Input = ("
         Treatment   Response
         'D1:C1'    1.0
         'D1:C1'    1.2
         'D1:C1'    1.3
         'D1:C2'    2.1
         'D1:C2'    2.2
         'D1:C2'    2.3
         'D2:C1'    1.4
         'D2:C1'    1.6
         'D2:C1'    1.7
         'D2:C2'    2.5
         'D2:C2'    2.6
         'D2:C2'    2.8
         'Control'  1.0
         'Control'  0.9
         'Control'  0.8
         ")
Data = read.table(textConnection(Input),header=TRUE)
Data$Treatment = factor(Data$Treatment, levels=unique(Data$Treatment))
# Specifying the order of factor levels
Data
levels(Data$Treatment)
ggplot(data = Data, mapping = aes(x = Treatment, y = Response), labs( x = "Treatment", y = "Treatment") + geom_boxplot(na.rm = TRUE))
       # boxplot(Response ~ Treatment, data = Data, ylab="Response", xlab="Treatment")
       
       ###  Define linear model
       model = lm(Response ~ Treatment, data = Data)
       # must have library car
       Anova(model, type="II")
       summary(model)
       # to construct the contrasts you better see the orther 
       leastsq = emmeans(model, "Treatment")
       # Contrasts for factors
       Contrasts = list(D1vsD2          = c(1,  1, -1, -1,  0),
                        C1vsC2          = c(1, -1,  1, -1,  0),
                        InteractionDC   = c(1, -1, -1,  1,  0),
                        C1vsC2forD1only = c(1, -1,  0,  0,  0),
                        C1vsC2forD2only = c(0,  0,  1, -1,  0),
                        TreatsvsControl = c(1,  1,  1,  1, -4),
                        T1vsC           = c(1,  0,  0,  0, -1),
                        T2vsC           = c(0,  1,  0,  0, -1),
                        T3vsC           = c(0,  0,  1,  0, -1),
                        T4vsC           = c(0,  0,  0,  1, -1))
       ### The column names match the order of levels of the treatment variable
       ### The coefficients of each row sum to 0
       contrast(leastsq, Contrasts, adjust="sidak")
       #
       # Example with multicomp
       Input = ("
Contrast.Name     D1C2  D1C2 D2C1 D2C2  Control
 D1vsD2            1     1   -1   -1     0
 C1vsC2            1    -1    1   -1     0
 InteractionDC     1    -1   -1    1     0
 C1vsC2forD1only   1    -1    0    0     0
 C1vsC2forD2only   0     0    1   -1     0
 TreatsvsControl   1     1    1    1    -4
 T1vsC             1     0    0    0    -1
 T2vsC             0     1    0    0    -1
 T3vsC             0     0    1    0    -1
 T4vsC             0     0    0    1    -1
")
       
       Matriz = as.matrix(read.table(textConnection(Input), header=TRUE, row.names=1))
       Matriz
       G = glht(model, linfct = mcp(Treatment = Matriz))
       G$linfct
       summary(G, test=adjusted("single-step"))
