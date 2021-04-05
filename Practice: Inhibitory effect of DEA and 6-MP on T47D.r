#Unpublished data
#DEA: Disodium ellagic acid, 6-MP: 6-Mercaptopurine, T47D: T47D human breast cancer cell line

rm(list = ls())
library(ggplot2)
library(dplyr)

file.choose()
DEA24 <- read.csv("file path")
glimpse(DEA24)

#Generate a plot with net-trends
ggplot(DEA24, aes(x = Dosage, y = Absorbance, colour = Drug)) +
  geom_point(size = 2) +
  geom_line() +
  geom_smooth(method = 'lm', size = 0.5, level = 0.3, linetype = "dashed") +
  xlab("Dosage (μg/ml)") +
  ylab("Abosrbance")+
  theme(text = element_text(family = "Times New Roman")) +
  scale_x_continuous(limits = c(0,1000), breaks=seq(0,1000,200)) +
  ggsave("4a.png")
