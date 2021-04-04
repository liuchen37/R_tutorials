rm(list = ls())

#ggplot2 foundation tutorial, Chen
#demo data = compensation.csv, (Crawley, 2012) https://github.com/shifteight/R-lang/blob/master/TRB/data/ipomopsis.txt

library(ggplot2)
library(dplyr)

#Make a simple bivarite, plain scatterplot of .compensation
ggplot(compensation, aes(x = Root, y = Fruit)) + 
  geom_point()

#get rid of the gray background, dot sized to 3, using bw theme
#Refer to "/liuchen37/R_tutorials/Reference: Themes in ggplot2"
ggplot(compensation, aes(x = Root, y = Fruit)) +
  geom_point(size = 3) +
  theme_bw()

#Add axis labels
ggplot(compensation, aes(x = Root, y = Fruit)) +
  geom_point(size = 3) +
  xlab("Root Biomass") +
  ylab("Fruit Production") +
  theme_bw()

#Similarly, use shape to discriminate grazing treatments
ggplot(compensation, aes(x = Root, y = Fruit)) +
  geom_point(size = 3) +
  xlab("Root Biomass") +
  tlab("Fruit Production") +
  theme_bw()

#Generate a box plot demostrating relationship between fruits production and grazing treatment, with presentation of indivudual result
#alpha = transperency
ggplot(compensation, aes(x = Grazing, y = Fruit)) +
  geom_boxplot() +
  geom_point(size = 2, color = 'lightgray', alpha = 0.7) +
  ylab("Fruit Production") +
  xlab("Grazing Treatment") +
  theme_bw()

#Plot a histrogram overseas fruit production
ggplot(compensation, aes(x = Fruit)) +
  geom_histogram(bins = 10, binwidth = 15)

#Present separated graphs for grazed and ungrazed, and save
ggplot(compensation, aes(x = Fruit)) +
  geom_histogram(bins = 10, binwidth = 15) +
  facet_wrap(~Grazing)
  ggsave("histo.png")

#Practice using real-world data
#How Chemotherapy affect BC patients survival
#Data sourse: Nicolau, M. et al. (2011) PNAS, 108(17): 7256-70.
file.choose()
BC <- read.csv("file path")
summary(BC)
Hormonal <- c(
  'false' = "No HRT",
  'true' = "HRT"
)
HRT_labeller <- function(variable, value){
  return(Hormonal[value])
}
ggplot(BC, aes(x = chemo, y = survival)) +
  geom_point() +
  xlab("Chemotherapy") +
  ylab("Survival (Mo)") +
  geom_boxplot() +
  facet_wrap(~hormonal, labeller = HRT_labeller) +
  ggsave("BC.png")
