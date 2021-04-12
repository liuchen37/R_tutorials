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

#ANCOVA, Analysis of covariance
#A combination of one-way ANOVA and linear regression
#demo data: limpet.csv
#"liuchen37/R_tutorials/limpet.csv"

rm(list = ls())
file.choose()
limpet <- read.csv("file path", stringsAsFactors = T)
glimpse(limpet)

#Produce a point scatter
ggplot(limpet, aes(x = DENSITY, y = EGGS, colour = SEASON)) +
  geom_point() +
  scale_colour_manual(values = c(spring ="green", summer = "red")) +
  xlab("Density") +
  ylab("Egg production") +
  theme_bw() +
  ggsave("6.2.png")

#Construct an lm, H0 both season, density have distinct effect on egg production
linear <- lm(EGGS ~ DENSITY * SEASON, data = limpet)
autoplot(linear, smooth.colour = NA)

anova(linear)

## Analysis of Variance Table
## 
## Response: EGGS
##                Df Sum Sq Mean Sq F value    Pr(>F)    
## DENSITY         1 5.0241  5.0241 30.1971 2.226e-05 ***
## SEASON          1 3.2502  3.2502 19.5350 0.0002637 ***
## DENSITY:SEASON  1 0.0118  0.0118  0.0711 0.7925333    
## Residuals      20 3.3275  0.1664                      
## ---
## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#DENSITY:SEASON p=0379, "we found no evidence for an interaction between density and season, indicating that the effects of density and season are addictive."

summary(linear)

## Call:
## lm(formula = EGGS ~ DENSITY * SEASON, data = limpet)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.65468 -0.25021 -0.03318  0.28335  0.57532 
## 
## Coefficients:
##                      Estimate Std. Error t value Pr(>|t|)    
## (Intercept)           2.664166   0.234118  11.380 3.45e-10 ***
## DENSITY              -0.033650   0.008259  -4.074 0.000591 ***
## SEASONsummer         -0.812282   0.331092  -2.453 0.023450 *  
## DENSITY:SEASONsummer  0.003114   0.011680   0.267 0.792533    
## ---
## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
## 
## Residual standard error: 0.4079 on 20 degrees of freedom
## Multiple R-squared:  0.7135,	Adjusted R-squared:  0.6705 
## F-statistic:  16.6 on 3 and 20 DF,  p-value: 1.186e-05

#Visualize the lm
coef(linear)

##          (Intercept)              DENSITY         SEASONsummer 
##          2.664166462         -0.033649651         -0.812282493 
## DENSITY:SEASONsummer 
##          0.003113571 
# Egg_spring=2.66-0.33xDENSITY, Egg_Summer=(2.66-0.81)+(-0.033+0.003)DENSITY
-0.033+0.003
2.66-0.81
# Egg_summer=1.85-0.03xDENSITY

predict(linear)

##         1         2         3         4         5         6         7 
## 2.3949692 2.3949692 2.3949692 1.6075953 1.6075953 1.6075953 2.1594217 
##         8         9        10        11        12        13        14 
## 2.1594217 2.1594217 1.3938428 1.3938428 1.3938428 1.6546769 1.6546769 
##        15        16        17        18        19        20        21 
## 1.6546769 0.9358016 0.9358016 0.9358016 1.1499321 1.1499321 1.1499321 
##        22        23        24 
## 0.4777604 0.4777604 0.4777604 

expanded_x <- expand.grid(DENSITY = seq(from = 8, to = 45, length.out = 10), SEASON = levels(limpet$SEASON))
head(expanded_x)
   DENSITY

##    DENSITY SEASON
## 1  8.00000 spring
## 2 12.11111 spring
## 3 16.22222 spring
## 4 20.33333 spring
## 5 24.44444 spring
## 6 28.55556 spring

expanded_y <- predict(linear, newdata = expanded_x, interval = 'confidence')
head(expanded_y)

##        fit      lwr      upr
## 1 2.394969 2.019285 2.770654
## 2 2.256632 1.931230 2.582034
## 3 2.118294 1.834274 2.402315
## 4 1.979957 1.724062 2.235852
## 5 1.841619 1.595998 2.087241
## 6 1.703282 1.447918 1.958646

add <- data.frame(expanded_x, expanded_y)
add <- rename(add, EGGS = fit)
head(add)

##    DENSITY SEASON EGGS      lwr      upr
## 1  8.00000 spring 2.394969 2.019285 2.770654
## 2 12.11111 spring 2.256632 1.931230 2.582034
## 3 16.22222 spring 2.118294 1.834274 2.402315
## 4 20.33333 spring 1.979957 1.724062 2.235852
## 5 24.44444 spring 1.841619 1.595998 2.087241
## 6 28.55556 spring 1.703282 1.447918 1.958646

ggplot(limpet, aes(x = DENSITY, y = EGGS, colour = SEASON)) +
  geom_point() +
  geom_smooth(data = add, aes(ymin = lwr, ymax = upr, fill = SEASON), stat = 'identity') +
  scale_colour_manual(values = c(spring = "green", summer = "red")) +
  scale_fill_manual(values = c(spring = "green", summer = "red")) +
  theme_bw() +
  ggsave("6.3.png")
