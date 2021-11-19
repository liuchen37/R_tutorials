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

This step loads the target file as a non-previewable value:

![alt text](https://github.com/liuchen37/Pics/blob/main/Test_as_value.jpg?raw=true)

## **Remove** a sheet from the file

Eg: Remove **sheet 2** from test:

![alt text](https://github.com/liuchen37/Pics/blob/main/Before_removal.jpg?raw=true)

```r
removeWorksheet(test, 2) #Remove the *second* sheet
saveWorkbook(test, "Removed2.xlsx", overwrite = TRUE) #save and export to a file
```

![alt text](https://github.com/liuchen37/Pics/blob/main/After_removal.jpg?raw=true)
