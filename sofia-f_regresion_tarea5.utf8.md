---
title: "Tarea sampleo en regresion"
author: "Sofia Fernandez"
date: "September 6, 2018"
output: pdf_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Problema

Refer to the data for 1050 subjects with cerebral edema (CEREBRAL). Cerebral edema with consequent increased intracranial pressure frequently accompanies lesions resulting from head injury and other conditions that adversely affect the integrity of the brain. 
Available treatments for cerebral edema vary in effectiveness and undesirable side effects. 
One such treatment is glycerol, administered either orally or intravenously. 
Of interest to clinicians is the relationship between intracranial pressure and glycerol plasma concentration.
Suppose you are a statistical consultant with a research team investigating the relationship between these two variables. Select a simple random sample from the population and perform the analysis that you think would be useful to the researchers. 

```{r library, message=FALSE, warning=FALSE, include=FALSE}
library(tidyverse)
```
# Codigo 

Se lee la base de datos completa de los 1050 sujetos del archivo csv y se cambian los nombres de las variables. 

```{r data}
cereb <- read_csv("data_daniels/ch09_all/LDS_C09_CEREBRAL.csv")
names(cereb) <- c("sub", "glyc", "icp")
```

## Muestreo de 50 sujetos

### Grafica de `ggplot2`

Con el paquete de `ggplot2` se hace una grafica exploratoria de los datos muestreados y aplicando una linea del modelo con la funcion de `geom_smooth()`. 

```{r ggplot50}
ggplot(data = cereb_50, mapping = aes(x = glyc, y = icp)) + geom_point(na.rm = TRUE) + 
    geom_smooth(method = "lm", se = FALSE, colour = "red")+ 
    geom_jitter(height = 0.03, width = 0.03)
```

### Exploracion del modelo

Se aplica el modelo de regresion lineal con la funcion `lm()` a la muestra. Una vez obtenido el modelo, se exploran las graficas y los resultados. 

```{r 50subsgraphs}
cereb_50 <- sample_n(cereb, 50)
par(mfrow=c(2,2))
plot(mod_cereb_250)
```

```{r 50subssumm}
summary(mod_cereb_250)
```
