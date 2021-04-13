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
