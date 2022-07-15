apop <- read.table("Kegg_apop.txt",header = T, sep = "\t")
apop <- apop$Symbol

library(dplyr)
fibroblast <- read.csv("fibroblast_diff.csv",header = T)
findapop1 <- fibroblast[which( fibroblast[,1]%in% apop ),]
findapop1 <- findapop1  %>% filter(cohen > 0.2)

#write.csv(findapop1, "fibroblast_all_enriched_apop.csv")

library(dplyr)
induced <- read.csv("induced_neurons_diff.csv",header = T)
findapop2 <- induced[which(induced[,1]%in% apop ),]
findapop2 <- findapop2  %>% filter(cohen > 0.2)
#write.csv(findapop2, "induced_neurons_all_enriched_apop.csv")

library(dplyr)
stem <- read.csv("neuro_stem_cells_diff.csv",header = T)
findapop3 <- stem[which( stem[,1]%in% apop),]
findapop3 <- findapop3  %>% filter(cohen > 0.2)
#write.csv(findapop3, "neuro_stem_cells_all_enriched_apop.csv")


all<- read.csv("xdp_control_all_cells.csv",header = T)
findapop4 <- all[which( all[,1]%in% apop ),]
findapop4 <- findapop4  %>% filter(cohen > 0.2)
#write.csv(findapop4, "all_cells_all_enriched_apop.csv")

dff <- full_join(findapop1[,c("gene","cohen")],findapop2[,c("gene","cohen")], by = "gene")
colnames(dff)[2:3] <- c("cohen_fibroblast_eniched", "cohen_induced_neuron_enriched")
dff <- findapop3[,c("gene","cohen")] %>% full_join(dff, by = "gene")
colnames(dff)[2] <- c("cohen_neuron_stem_cells_enriched")
dff <-  findapop4[,c("gene","cohen")] %>% full_join(dff, by = "gene")
colnames(dff)[2] <- c("cohen_for_all_celltypes_in_xdp_enriched")

write.csv(dff, "Table_6.csv")

#x <- findapop1
#y <- inner_join(findapop2, findapop3, by ='gene')
#write.csv(y, "apop_in_neurons.csv")
#z <- inner_join(x, y, by ='gene')
#write.csv(z, "apop_in_3_celltype.csv")

#z <- inner_join(z , findapop4, by ='gene')
#write.csv(z, "apop_in_everything.csv")

#z <- inner_join(y , findapop4, by ='gene')
#write.csv(z, "apop_in_neuron_andeverything.csv")

#z <- inner_join(findapop2 , findapop4, by ='gene')
#write.csv(z, "apop_in_inducedneuron_andeverything.csv")

