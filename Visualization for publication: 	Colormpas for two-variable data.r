#7.2 	Colormpas for two-variable data
#Demo data: WorldPhones, built-in with R

rm(list = ls())
wp <- WorldPhones

#Contrast a heatmap
heatmap(wp)

#Remove the dendrogram
heatmap(wp, Rowv = NA, Colv = NA)

#Add colour scale to the groups
cc <- rainbow(ncol(wp), start = 0, end = 0.3)
heatmap(wp, ColSideColors = cc)

#Rescale
heatmap(wp, ColSideColors = cc, scale = "column")
