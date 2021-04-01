#demo.data
#Log transform
demo.data$log2<- log2(demo.data$column name)

#Compute median and confidential range (by determining P1, P3)
M<- meidian(demo.data$column name)
P1<- quantile(demo.data$log2, 0.1587, type = 5)
P3<- quantile(demo.data$log2, 0.8413, type = 5)

#Define function 
#E.g.: Cox and Mann. 2008. Nature Biotechnology, 26(12): 1367-72, Equation 1-2.
#Equation 1, output Z
demo.data$Z<- ifelse(demno.data$log2 >= 0, (demo.data$log2 - M)/(P3 - M), (demo,data$log2 - M)/(M- P1))
#Equation 2, define erfc
erfc <- function(x) 2 * pnorm(x * sqrt(2), lower = FALSE)
#Equation 2, output significance A (p)
demo.data$p<- 0.5*erfc(abs(demo.data$Z)/sqrt(2))
