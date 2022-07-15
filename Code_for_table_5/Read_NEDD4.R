NEDD4 <- c("IGF1R", "IGF1", "HSF1")
library(dplyr)
induced <- read.csv("induced_neurons_diff.csv",header = T)
finde32 <- induced[which(induced[,1]%in% NEDD4 ),]
write.csv(finde32, "Table_5.csv")
