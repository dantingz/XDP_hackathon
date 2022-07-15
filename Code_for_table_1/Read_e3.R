e3_ligase <- read.csv("E3.csv", header= T)
e3_ligase <- e3_ligase[,1]

library(dplyr)
fibroblast <- read.csv("fibroblast_diff.csv",header = T)
finde3 <- fibroblast[which( fibroblast[,1]%in% e3_ligase ),]
finde3 <- finde3  %>% filter(cohen > 0.2)

#write.csv(finde3, "fibroblast_all_enriched_e3.csv")

library(dplyr)
induced <- read.csv("induced_neurons_diff.csv",header = T)
finde32 <- induced[which(induced[,1]%in% e3_ligase ),]
finde32 <- finde32  %>% filter(cohen > 0.2)
#write.csv(finde32, "induced_neurons_all_enriched_e3.csv")


library(dplyr)
stem <- read.csv("neuro_stem_cells_diff.csv",header = T)
finde33 <- stem[which( stem[,1]%in% e3_ligase ),]
finde33 <- finde33  %>% filter(cohen > 0.2)
#write.csv(finde33, "neuro_stem_cells_all_enriched_e3.csv")


all <- read.csv("xdp_control_all_cells.csv",header = T)
finde34 <- all[which( all[,1]%in% e3_ligase ),]
finde34 <- finde34  %>% filter(cohen > 0.2)
#write.csv(finde34, "all_cells_all_enriched_e3.csv")

dff <- full_join(finde3[,c("gene","cohen")],finde32[,c("gene","cohen")], by = "gene")
colnames(dff)[2:3] <- c("cohen_fibroblast_eniched", "cohen_induced_neuron_enriched")
dff <- finde33[,c("gene","cohen")] %>% full_join(dff, by = "gene")
colnames(dff)[2] <- c("cohen_neuron_stem_cells_enriched")
dff <-  finde34[,c("gene","cohen")] %>% full_join(dff, by = "gene")
colnames(dff)[2] <- c("cohen_for_all_celltypes_in_xdp_enriched")
write.csv(dff, "Table_1.csv")



#x <- finde3
#y <- inner_join(finde32, finde33, by ='gene')
#write.csv(y, "e3_in_neurons.csv")
#z <- inner_join(x, y, by ='gene')
#write.csv(z, "e3_in_3_celltype.csv")

#z <- inner_join(z , finde34, by ='gene')
#write.csv(z, "e3_in_everything.csv")

#z <- inner_join(y , finde34, by ='gene')
#write.csv(z, "e3_in_neuron_andeverything.csv")

#z <- inner_join(finde32 , finde34, by ='gene')
#write.csv(z, "e3_in_inducedneuron_andeverything.csv")

