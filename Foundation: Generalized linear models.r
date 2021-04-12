#Generalized linear models (GLM)
rm(list = ls())
library(dplyr)
library(ggplot2)
library(ggfortify)
file.choose()
sheepcount <- read.csv("file path")
glimpse(sheepcount)

#A glance
ggplot(sheepcount, aes(x = body.size, y = fitness)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  geom_smooth(span = 1, colour = "red", se = FALSE) +
  theme_bw()

#Does a GENRAL linear model fits this data?
gnrlinear <- lm(fitness ~ body.size, data = sheepcount)
autoplot(gnrlinear, smooth.colour = NA, size = 1)
ggplot(sheepcount, aes(x = body.size)) +
  geom_histogram(bins = 10) +
  theme_bw()
#Both diagnose plots and histogram indicated that the data failed to fit into a general linear model, therefore a glm is needed

#Contruct a glm
sheepglm <- glm(fitness ~ body.size, data = sheepcount, family = poisson(link = log))
autoplot(sheepglm, smooth.colour = NA)

anova(sheepglm, test = "Chisq")
summary(sheepglm)

