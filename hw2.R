#7.4.1
pre <- c(12, 10, 16, 2,
         12, 18, 11, 16,
         16, 10, 14, 21,
         9, 19, 20)
post <- c(11, 10, 11, 3,
          9, 13, 8, 14,
          16, 10, 12, 22,
          9, 16, 18)
gds <- tibble(pre, post)

t.test(gds$pre, 
       gds$post, 
       alternative = "g", 
       paired = T, 
       conf.level = 0.99)

#7.4.2
sub <- 1:66

baseline <- c(16, 26, 13, 20, 22, 21,
        20, 15, 25, 20, 11, 22,
        18, 21, 25, 17, 26, 18,
        7, 25, 22, 15, 19, 23,
        19, 21, 24, 21, 28, 18,
        25, 25, 28, 25, 21, 14,
        23, 19, 19, 18, 20, 18, 
        22, 7, 23, 19, 17, 22, 
        19, 5, 22, 12, 19, 17,
        7, 27, 22, 16, 26, 17,
        23, 23, 13, 24, 17, 22)

follow_up <- c(19, 19, 9, 23, 25, 20,
               10, 20, 22, 18, 6, 21,
               17, 13, 25, 21, 22, 22,
               9, 24, 15, 9, 7, 20,
               19, 24, 23, 15, 27, 26,
               26, 26, 28, 14, 17, 22,
               22, 16, 15, 23, 21, 11,
               22, 17, 9, 16, 16, 20,
               23, 17, 17, 6, 19, 20, 
               6, 10, 16, 14, 24, 19,
               22, 23, 3, 22, 21, 21) 

fact_g <- tibble(sub, baseline, follow_up)

t.test(fact_g$baseline, 
       fact_g$follow_up,
       alternative = "g", 
       paired = T)

#7.4.3
sub <- 1:11

methadone <- c(29.8, 73, 98.6,
               58.8, 60.6, 57.2, 
               57.2, 89.2, 97, 
               49.8, 37)

placebo <- c(57.2, 69.8, 98.2,
             62.4, 67.2, 70.6, 
             67.8, 95.6, 98.4, 
             63.2, 63.6)
neuro_pain <- tibble(sub, methadone, placebo)

t.test(neuro_pain$methadone, 
       neuro_pain$placebo,
       alternative = "l",
       paired = T)

#7.4.4
sub <- 1:20

baseline <- c(5.9, 7.6, 12.8, 16.5, 6.1,
              14.4, 6.6, 5.4, 9.6, 11.6,
              11.1, 15.6, 6.9, 15.2, 21,
              5.9, 10, 12.2, 20.2, 6.2)

tx8 <- c(5.2, 12.2, 4.6, 4, 0.4,
         3.8, 1.2, 3.1, 3.5, 4.9,
         11.1, 8.4, 5.8, 5, 6.4,
         0, 2.7, 5.1, 4.8, 4.2)

pasi <- tibble(sub, baseline, tx8)

t.test(pasi$baseline,
       pasi$tx8,
       alternative = "g",
       paired = T,
       conf.level = 0.99)

#7.4.5
baseline <- c(173, 58, 103, 181, 105, 301, 169)
follow_up <- c(257, 108, 315, 362, 141, 549, 369)
haart <- tibble(baseline, follow_up)

haart %>% 
    gather(key = "stage", 
           value = "cd4_t", 
           baseline, 
           follow_up) %>% 
    ggplot(aes(stage, 
               cd4_t)) + 
        geom_boxplot()

t.test(haart$baseline,
       haart$follow_up,
       alternative = "t",
       paired = T,
       conf.level = 0.95)




















