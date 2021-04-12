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

#Visualization

#Expand data
minsize <- min(sheepcount$body.size)
maxsize <- max(sheepcount$body.size)
newx <- expand.grid(body.size = seq(minsize, maxsize, length = 1000))

newy = predict(sheepglm, newdata = newx, se.fit = TRUE)
newdata <- data.frame(newx, newy)
head(newdata)

newdata <- mutate(newdata,
                  fitness = exp(fit),
                  lwr = fitness - 1.96 * se.fit,
                  upr = fitness + 1.96 * se.fit)
head(newdata)

ggplot(sheepcount, aes(x = body.size, y = fitness)) +
  geom_point(size = 3, alpha = 0.5) +
  geom_smooth(data = newdata, aes(ymin = lwr, ymax = upr), stat = 'identity') +
  theme_bw() +
  ggsave("7.1.png")
