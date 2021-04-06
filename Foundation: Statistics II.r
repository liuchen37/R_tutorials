#Statistics II: Two-way ANOVA and analysis of covariance (ANCOVA)
#Chen

rm(list = ls())
library(dplyr)
library(ggplot2)
library(ggfortify)

#Two-way ANOVA
#Cow growth, "liuchen37/R_tutorials/growth.csv"
file.choose()
moo <- read.csv("file path", stringsAsFactors = T)
glimpse(moo)

## Rows: 48
## Columns: 3
## $ supplement <fct> "supergain", "supergain", "supergain", "supergain", "contro…
## $ diet       <fct> "wheat", "wheat", "wheat", "wheat", "wheat", "wheat", "whea…
## $ gain       <dbl> 17.37125, 16.81489, 18.08184, 15.78175, 17.70656, 18.22717,…

#Check individual factors
levels(moo$supplement)

## [1] "agrimore"  "control"   "supergain" "supersupp"

levels(moo$diet)

## [1] "barley" "oats"   "wheat"

#Relevel "control" as reference (first place)
moo <- mutate(moo, supplement = relevel(supplement, ref = "control"))
levels(moo$supplement)

## [1] "control"   "agrimore"  "supergain" "supersupp"

#Calculate mean and plot
sumMoo <- moo %>%
  group_by(diet, supplement) %>%
  summarise(meanGrow = mean(gain))
ggplot(sumMoo, aes(x = supplement, y = meanGrow, colour = diet, group = diet)) +
  geom_point() +
  geom_line() +
  theme_bw() +
  ggsave("6.1.png")

#Construct linear model and plot diagnosis
linear <- lm(gain ~ diet * supplement, data = moo)
autoplot(linear, smooth.colour = NA)

#ANOVA
anova(linear)

## Analysis of Variance Table
## 
## Response: gain
##                 Df  Sum Sq Mean Sq F value    Pr(>F)    
## ## diet             2 287.171 143.586 83.5201 2.999e-14 ***
## supplement       3  91.881  30.627 17.8150 2.952e-07 ***
## diet:supplement  6   3.406   0.568  0.3302    0.9166    
## Residuals       36  61.890   1.719                      
## ---
## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#p(diet~supplement)=0.9 => we found no evidence to support the presence of an interaction between diet and eupplement (F=0.33; df=6.36; p=0.92).

#ANCOVA
#demo data: limpet.csv
#"liuchen37/R_tutorials/limpet.csv"
