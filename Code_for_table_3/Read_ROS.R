ROS <- read.table("ROS.txt",header = T, sep = "\t")
ROS <- ROS$Genesymbol

library(dplyr)
fibroblast <- read.csv("fibroblast_diff.csv",header = T)
findROS1 <- fibroblast[which( fibroblast[,1]%in% ROS ),]
findROS1 <- findROS1  %>% filter(cohen > 0.2)

#write.csv(findROS1, "fibroblast_all_enriched_ROS.csv")

library(dplyr)
induced <- read.csv("induced_neurons_diff.csv",header = T)
findROS2 <- induced[which(induced[,1]%in% ROS ),]
findROS2 <- findROS2  %>% filter(cohen > 0.2)
#write.csv(findROS2, "induced_neurons_all_enriched_ROS.csv")

library(dplyr)
stem <- read.csv("neuro_stem_cells_diff.csv",header = T)
findROS3 <- stem[which( stem[,1]%in% ROS),]
findROS3 <- findROS3  %>% filter(cohen > 0.2)
#write.csv(findROS3, "neuro_stem_cells_all_enriched_ROS.csv")


all<- read.csv("xdp_control_all_cells.csv",header = T)
findROS4 <- all[which( all[,1]%in% ROS ),]
findROS4 <- findROS4  %>% filter(cohen > 0.2)
#write.csv(findROS4, "all_cells_all_enriched_ROS.csv")

dff <- full_join(findROS1[,c("gene","cohen")],findROS2[,c("gene","cohen")], by = "gene")
colnames(dff)[2:3] <- c("cohen_fibroblast_eniched", "cohen_induced_neuron_enriched")
dff <- findROS3[,c("gene","cohen")] %>% full_join(dff, by = "gene")
colnames(dff)[2] <- c("cohen_neuron_stem_cells_enriched")
dff <-  findROS4[,c("gene","cohen")] %>% full_join(dff, by = "gene")
colnames(dff)[2] <- c("cohen_for_all_celltypes_in_xdp_enriched")

write.csv(dff, "Table_3.csv")

#x <- findROS1
#y <- inner_join(findROS2, findROS3, by ='gene')
#write.csv(y, "ROS_in_neurons.csv")
#z <- inner_join(x, y, by ='gene')
#write.csv(z, "ROS_in_3_celltype.csv")

#z <- inner_join(z , findROS4, by ='gene')
#write.csv(z, "ROS_in_everything.csv")

#z <- inner_join(y , findROS4, by ='gene')
#write.csv(z, "ROS_in_neuron_andeverything.csv")

#z <- inner_join(findROS2 , findROS4, by ='gene')
#write.csv(z, "ROS_in_inducedneuron_andeverything.csv")

