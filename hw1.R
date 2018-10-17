library(tidyverse)

##3.2.4
#1
mpg_p <- ggplot(mpg)

mpg_p

#2
mpg

#3
?mpg #drv: f = front-wheel drive, r = rear wheel drive, 4 = 4wd

#4
mpg_p + 
    geom_point(aes(hwy, cyl))

#5
mpg_p + 
    geom_point(aes(class, drv))

##3.3.1
#1
mpg_p + 
    geom_point(aes(displ, hwy, colour = "blue")) #incorrect; 
#assigns colour based on a missing attribute 'blue'

mpg_p +
    geom_point(aes(displ, hwy), colour = "blue") #correct; 
#colour attribute is set outside of the aesthetics function

#2
?mpg
str(mpg)

#3
mpg_p1 <- ggplot(mpg, aes(displ, hwy))

mpg_p1 + geom_point(aes(colour = cty))
mpg_p1 + geom_point(aes(colour = class))

mpg_p1 + geom_point(aes(size = cty))
mpg_p1 + geom_point(aes(size = class))

mpg_p1 + geom_point(aes(shape = cty))
mpg_p1 + geom_point(aes(shape = class))

#4
mpg_p1 + geom_point(aes(shape = fl, colour = fl))

#5
mpg_p1 + geom_point(aes(stroke = fl))

##3.5 Facets

#Setting up the base for the plots
mpg_p1 <- ggplot(mpg, aes(displ, hwy))

#Example #1
mpg_p1 + 
    geom_point() + 
    facet_wrap(~ class, nrow = 2)
#Example #2
mpg_p1 + 
    geom_point() + 
    facet_grid(drv ~ cyl)

##3.5.1 Exercises

#1 What happens if you facet a continuous variable? 
mpg_p1 + geom_point() + facet_wrap(~ cty)

#Ans: There is a facet for every level of the variable 


#2 What do the empty cells in plot with 'facet_gri(drv ~ cyl) mean? How do they relate to this plot?

ex <- ggplot(mpg, aes(drv, cyl)) + geom_point()

ex
mpg_p1 + geom_point() + facet_grid(drv ~ cyl)


mpg_p1 + geom_point() + facet_grid(cyl ~ drv) 
ex + scale_y_reverse()

#Ans: There are no cars with that combination of number of cylinders and wheel-drive

#3 What plots does the following code make? What does . do? 
mpg_p1 + geom_point() + facet_grid(drv ~ .)
mpg_p1 + geom_point() + facet_grid(. ~ cyl)

#Ans: The point makes the plot to not facet any variable on either the rows or columns. The point is a placeholder so the formula won't be one-sided.

#4 Take the first faceted plot in this section
mpg_p1 + geom_point() + facet_wrap(~ class, nrow = 2)
mpg_p1 + geom_point(aes(colour = class))

#Advantages: The information is more clearer and easier to read than using color. It's better when there are a lot of different values in that variable. 
#Disadvantages: By separating the variables it's more difficult to compare between them. 

#5 Read the man
?facet_wrap
?facet_grid
#What does nrow do? It sets the number of rows in the facet
#What does ncol do? It sets the number of columns in the facet
#What other options control the layout of the individual panels? drop: not showing the not used levels in the data; scales: allows for the scales to be different by the panels; space: lets the size of the panels be different it must be used with 'scales'. 
#Why doesn't facet_grid() have nrow and ncol arguments? Because facet_grid accomodates the graph according to the number of levels in the variables 

#6 When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?

mpg_p1 + geom_point() + facet_grid(drv ~ cyl)
mpg_p1 + geom_point() + facet_grid(cyl ~ drv)

#Ans: so the graph is wider instead of longer and easier to read. The screens are generally wider than longer. 