# Openxlse

[Documentation](https://www.rdocumentation.org/packages/openxlsx/versions/4.2.4/topics/removeWorksheet)

## Install and load the package

```r
rm(list = ls())
install.packages("openxlsx")
library(openxlsx)
```

## Load the .xlsx file

```r
file.choose()
test <- loadWorkbook("file.location")
```

This step loads the target file as a non-previewable object:

![alt text](https://github.com/liuchen37/Pics/blob/main/Test_as_value.jpg?raw=true)

## Remove a sheet

Eg: Remove **sheet 2** from test:

![alt text](https://github.com/liuchen37/Pics/blob/main/Before_removal.jpg?raw=true)

```r
removeWorksheet(test, 2) #Remove the second sheet
saveWorkbook(test, "Removed2.xlsx", overwrite = TRUE) #save and export to a file
```

![alt text](https://github.com/liuchen37/Pics/blob/main/After_removal.jpg?raw=true)

## Rename a worksheet

Eg: Rename Sheet2 to Second_last

![alt text](https://github.com/liuchen37/Pics/blob/main/Before_removal.jpg?raw=true)

```r
names(test)[[2]] <- "Second_last"
saveWorkbook(test, "renamed2.xlsx", overwrite = TRUE)
```

![alt text](https://github.com/liuchen37/Pics/blob/main/Renamed.jpg?raw=true)
