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
## $ supplement <chr> "supergain", "supergain", "supergain", "supergain", "contro…
## $ diet       <chr> "wheat", "wheat", "wheat", "wheat", "wheat", "wheat", "whea…
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

#
