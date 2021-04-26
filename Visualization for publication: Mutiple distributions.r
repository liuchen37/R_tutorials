#7.1 Mutiple Distributions
#Demo data: Airquality, built-in data with R

library(ggplot2)
library(ggridges)
library(viridis)
library(dplyr)
library(tidyr)

airquality
aq <- airquality
glimpse(aq)

#Build a ggplot description
ggplot(aq, aes(x = Temp, y = Month, group = Month)) +
  geom_density_ridges()

#Add colours
ggplot(aq, aes(x = Temp, y = Month, group = Month, fill = ..x..)) +
  geom_density_ridges_gradient() +
  scale_fill_viridis(option = "C", name = "Temp")

#Split data into further dimensions and make facets
aq %>%
  gather(key = "Measurement", value = "value", Ozone, Solar.R, Wind, Temp ) %>%
  ggplot(aes(x = value, y = Month, group = Month)) +
  geom_density_ridges_gradient() +
  facet_wrap( ~ Measurement, scales = "free")
