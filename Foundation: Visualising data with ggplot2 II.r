# Visualising data with ggplot2 II, Chen
#Demo data: compensation.csv

#Install gridExtra and load files
rm(list = ls())
library(ggplot2)
install.packages("gridExtra")
library(gridExtra)

file.choose()
compensation <- read.csv("file path)
compensation

#Assign plots
egscatter <-
  ggplot(compensation, aes(x = Root, y = Fruit)) +
  geom_point()

egbox <-
  ggplot(compensation, aes(x = Root, y = Fruit)) +
  geom_boxplot()

#Add lines to existing assignment
egscatter + theme_bw()

#Arrangements
grid.arrange(egscatter, egbox, nrow= 1)
grid.arrange(egscatter, egbox, ncol= 1)

#Title
egscatter + ggtitle("Fruit production vs Root length")

#Axis limits
egscatter + xlim (6,8) + ylim(60 , 90)

