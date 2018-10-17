pacman::p_load(car, lsmeans, emmeans, multcomp, tidyverse)

hers <- read_csv("hersdata.csv")

hers_nodi <- filter(hers, diabetes == "no")

hers_nodi <- mutate(hers_nodi, physact = ordered(physact, levels = c("much less active", 
                                                                     "somewhat less active", 
                                                                     "about as active", 
                                                                     "somewhat more active", 
                                                                     "much more active")))
                    
ggplot(data = hers_nodi, mapping = aes(x = physact, y = glucose)) + geom_boxplot(na.rm = TRUE)

