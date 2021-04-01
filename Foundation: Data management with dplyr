#demo data (Crawley, 2012): https://github.com/shifteight/R-lang/blob/master/TRB/data/ipomopsis.txt

rm(list = ls())
library(dplyr)
library(ggplot2)

#Load file: compensation.csv
file.choose()
read.csv(file = "file path")

#A glance
glimpse(compensation)
as_tibble(compensation)
summary(compensation)

#dyplyr verbs
#Select columns
select(compensation, Root)
#Select rows
select_min(compensation, Root)
select_max(compensation, Fruit)
#Slice grab specific rows, eg: bring row 5-10
slice(compensation, 5:10)
#Filter
filter(compensation, Root < "5", Grazing == 'Ungrazed")
filter(compensation, Grazing != "Ungrazed")
#Use select and filter to see the statues of grazing when fruit>50
select(filter(compensation, Fruit > 50), Grazing)
#Arrange
arrange(compensation, Root)
#Mutate: use to modify data, eg: transform Root length from cm to inches
mutate(compensation, Root = Root * 0.393701)

#Establish mean value
#Method 1: nested, no pipe
#Find mean fruit production when grazed and ungrazed
mean.fruit <- summarise(
  group_by(compensation, Grazing),
  Meanfruit = mean(Fruit))
#Method 2: pipe, no nesting
compensation %>%
  group_by(Grazing) %>%
    summarise(meanFruit = mean(Fruit))

#Practice: Use data in the Weight-Height talbe to determine the mean heights and weights in different genders
#https://gist.github.com/nstokoe/7d4717e96c21b8ad04ec91f361b000cb
WH %>%
  group_by(Gender) %>%
  summarise(meanW = mean(Weight), meanH = mean(Height))
## A tibble: 2 x 3
##  Gender meanW meanH
##  <chr>  <dbl> <dbl>
##1 Female  136.  63.7
##2 Male    187.  69.0
