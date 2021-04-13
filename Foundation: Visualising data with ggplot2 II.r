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
  ggplot(compensation, aes(x = Grazing, y = Fruit)) +
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

#Annotation, by adding the coordinates of the centre of the text
egscatter + xlim (6,8) +
  ylim(60 , 90) +
  annotate("text", x = c(6.5, 7.5), y = c(85, 65), 
           label = c("No fruit production > 70 at 6-7 mm length", 
                     "Fruit > 70 when length > 7 mm"))

#Scales, add break from 5-10 per 1 mm
egscatter +
  scale_x_continuous(limits = c(5, 10), breaks = 5: 10)

#Manual colour
ggplot(compensation, aes(x = Root, y = Fruit, colour = Grazing)) +
  geom_point() +
  scale_colour_manual(values = c(Grazed = "brown", Ungrazed = "green"))

#Scale y axis but in a log10 manner
egbox +
  scale_y_continuous(breaks = seq(from = 50, to = 100, by = 10),
                     trans = "log10")

#Grid themes, rect for rectangle
egscatter +
  theme(
    panel.background = element_rect(fill = NA, colour = "black"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(colour= "blue"))

#Adjust angel of axis label
egbox +
  theme(
    axis.text.x = (element_text(angle = 45, vjust = 0.5)))

#More refer to [ggplot cheatsheet](https://github.com/rstudio/cheatsheets/blob/master/data-visualization-2.1.pdf)
