#Statistics and machine learning

# Statistics and machine learning

In this section we will focus on some useful but uncommon methods to process data. Including simulating datasets and machine learning, for class prediction and dimensionality reduction.

We will cover the following topics:

1. Correcting *p*-values to account for ultiple hypothesis
2. Generating a simulated dataset to represent a background
3. Learning groups within data and classifiying with ***k*-Nearest Neighbors (kNN)**
4. Predictig classes with random forests
5. predicting classes with **Support Vector Machine (SVM)**
6. Learning groups in data without proir information
7. Identifying the most important variables in data with random forests
8. Identifying the most important variables in data with **Principle Component Analysis (PCA)**

A bit of basic concept...Three classes of machine learning: *Supervised learning*, which based on labeled data to train the model; *Unsupervised learning* uses un labeled data; *Reinforcement learning* is the correction of current output.

In order to process these data, the following environment is required:
```r
rm(list = ls())

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install()

BiocManager::install(c(
    "Biobase",
    "caret"
    "class"
    "dylyr"
    "e1071"
    "factoextra"
    "fakeR"
    "magrittR"
    "radomForest"
    "RColorBrewer"
))
