#Statistics I: χ2 contingency analysis, simple t-test, linear regression and one-way ANOVA

rm(list = ls())

file.choose()
ladybird <- read.csv("file path")
library(dplyr)
library(ggplot2)
glimpse(ladybird)

## Rows: 20
## Columns: 4
## $ Habitat      <chr> "Rural", "Rural", "Rural", "Rural", "Rural", "Rural", "Ru…
## $ Site         <chr> "R1", "R2", "R3", "R4", "R5", "R1", "R2", "R3", "R4", "R5…
## $ morph_colour <chr> "black", "black", "black", "black", "black", "red", "red"…
## $ number       <int> 10, 3, 4, 7, 6, 15, 18, 9, 12, 16, 32, 25, 25, 17, 16, 17…

#χ2 contingency analysis
#demo data: ladybird morphology in rural and industrail areas, by Phil Warren
#"liuchen37/R_tutorials/ladybirds_morph_colour.csv"
#H0: no association between bird colours and their habitats

#Summarise observations in each group of colour
totals <- ladybird %>%
  group_by(Habitat, morph_colour) %>%
  summarise(total.observation = sum(number))
ggplot(totals, aes(x = Habitat, y = total.observation, fill = morph_colour)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  scale_fill_manual(values = c(black = "black", red = "red")) #position = 'dodge' means put two habitats seperated, rather than in one bar
ggsave("LadybirdTotal.png")

totals

## # A tibble: 4 x 3
## # Groups:   Habitat [2]
##   Habitat    morph_colour total.observation
##   <chr>      <chr>                    <int>
## 1 Industrial black                      115
## 2 Industrial red                         85
## 3 Rural      black                       30
## 4 Rural      red                         70

#Perfoming the χ2 test
#Constract a matrix consisting of habitat and colour
lady.mat <- xtabs(number ~ Habitat + morph_colour, data = ladybird)
lady.mat

##              morph_colour
##    Habitat    black red
##   Industrial   115  85
##   Rural         30  70

#χ2 test
chisq.test(lady.mat)

## Pearson's Chi-squared test with Yates' continuity correction
## 
## data:  lady.mat
## X-squared = 19.103, df = 1, p-value = 1.239e-05

#p<0.001, H0 rejected

#Two-sample t-test
#demo data: ozone levels in several gardens, inspired by Crawley (2012)
#"liuchen37/R_tutorials/GardenOzone.csv"

rm(list = ls())

file.choose()
ozone <- read.csv("file path")
glimpse(ozone)
ggplot(ozone, aes(x = Ozone)) +
  geom_histogram(binwidth = 10) +
  facet_wrap(~ Garden.location, ncol = 1) +
  theme_bw()
ggsave("5.2.png")

#Calculate mean ozone in W/E gardens (/)
ozone %>%
  group_by(Garden.location) %>%
  summarise(meanozone = mean(Ozone))
  
## # A tibble: 2 x 2
##   Garden.location meanozone
##   <chr>               <dbl>
## 1 East                 77.3
## 2 West                 61.3

#t-test
t.test(Ozone ~ Garden.location, data = ozone)

## 	Welch Two Sample t-test
## 
## data:  Ozone by Garden.location
## t = 4.2363, df = 17.656, p-value = 0.0005159
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##   8.094171 24.065829
## sample estimates:
## mean in group East mean in group West 
##              77.34              61.26 

#p<0.001

#Linear models

#Simple linear regression
#demo data: plant growth rate
#"/liuchen37/R_tutorials/plant.growth.rate.csv"

file.choose()
gr <- read.csv("file path")
glimpse(gr)

## Rows: 50
## Columns: 2
## $ soil.moisture.content <dbl> 0.4696876, 0.5413106, 1.6979915, 0.8255799, 0.85…
## $ plant.growth.rate     <dbl> 21.31695, 27.03072, 38.98937, 30.19529, 37.06547…

#produce a scatter plot
ggplot(gr, aes (x = soil.moisture.content, y = plant.growth.rate)) +
  geom_point() +
  xlab("soil moisture") +
  ylab("plant growth rate (mm/week)") +
  theme_bw()
ggsave("5.3.png")

#Construct a linear model (lm)
linear <- lm(plant.growth.rate ~ soil.moisture.content, data = gr)

#*ggfortify* is a extension for ggplot2
if(!require(devtools)) install.packages("devtools")
devtools::install_github("sinhrks/ggfortify")
library(ggfortify)

#Generate diagnostic plots
autoplot(linear, smooth.colour = NA)
#Upper-left: Fitness to a linear regression, if not fit, apparent will be hump-shapes or valleys
#Upper-right: Dots = residues, dotted line = normal distribution (fitnes)
#Lower-left: stantardised indicator of variation. In case of linear model, no pattern should be observed
#Lower-right: tool to investigate higher influntial residues, not so useful...
#No patterns observed with deata model = linear

#Two types of summarisation
anova(linear)

## Analysis of Variance Table
## 
## Response: plant.growth.rate
##                       Df  Sum Sq Mean Sq F value    Pr(>F)    
## soil.moisture.content  1 2521.15 2521.15  156.08 < 2.2e-16 ***
## Residuals             48  775.35   16.15                      
## ---
## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

summary(linear)

## Call:
## lm(formula = plant.growth.rate ~ soil.moisture.content, data = gr)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -8.9089 -3.0747  0.2261  2.6567  8.9406 
## 
## Coefficients:
##                       Estimate Std. Error t value Pr(>|t|)    
## (Intercept)             19.348      1.283   15.08   <2e-16 ***
## soil.moisture.content   12.750      1.021   12.49   <2e-16 ***
## ---
## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
## 
## Residual standard error: 4.019 on 48 degrees of freedom
## Multiple R-squared:  0.7648,	Adjusted R-squared:  0.7599 
## F-statistic: 156.1 on 1 and 48 DF,  p-value: < 2.2e-16

#Generate best-fit line
ggplot(gr, aes (x = soil.moisture.content, y = plant.growth.rate)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  xlab("Soil Moisture") +
  ylab("Plant Growth Rate (mm/weak)") +
  theme_bw() +
  ggsave("5.4.png")

#One-way ANOVA
#Demo data: daphniagrowth.csv
#
file.choose()
dphn <- read.csv("file path")
glimpse(dphn)

## Rows: 40
## Columns: 3
## $ parasite    <chr> "control", "control", "control", "control", "control", "contr…
## $ rep         <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,…
## $ growth.rate <dbl> 1.0747092, 1.2659016, 1.3151563, 1.0757519, 1.1967619, 1.3837…

#plot a boxplot
ggplot(dphn, aes(x = parasite, y = growth.rate)) +
  geom_boxplot() +
  theme_bw() +
  ggsave("5.5.png")

#Fix the long microbe name, by rotating the coordinates
ggplot(dphn, aes(x = parasite, y = growth.rate)) +
  geom_boxplot() +
  theme_bw() +
  xlab("Parasite") +
  ylab("Growth rate") +
  coord_flip () +
  ggsave("5.6.png")

#Construct a linear model for ANOVA
dphnlinear <- lm(data = dphn, growth.rate ~ parasite)

#Diagnostic plots
autoplot(dphnlinear, smooth.colour = NA)

#ANOVA
anova(dphnlinear)

## Analysis of Variance Table

## Response: growth.rate
##           Df Sum Sq Mean Sq F value    Pr(>F)    
## parasite   3 3.1379 1.04597  32.325 2.571e-10 ***
## Residuals 36 1.1649 0.03236                      
## ---
## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Make a summary  plot
ggplot(dphn, aes(x = growth.rate, y = parasite, colour = parasite)) +
  geom_point() +
  theme_bw()

#Mean
mean <- dphn %>%
  group_by(parasite) %>%
  summary(meanGR = mean(growth.rate))
meanGR

##    parasite              rep        growth.rate    
##  Length:40          Min.   : 1.0   Min.   :0.1246  
##  Class :character   1st Qu.: 3.0   1st Qu.:0.6490  
##  Mode  :character   Median : 5.5   Median :0.9502  
##                     Mean   : 5.5   Mean   :0.8934  
##                     3rd Qu.: 8.0   3rd Qu.:1.1250  
##                     Max.   :10.0   Max.   :1.3838 
