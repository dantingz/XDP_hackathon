lyso <- read.table("Lyso.txt",header = T, sep = "\t")
lyso <- lyso$PROBE
endo <- read.table("KEGG_ENDOCYTOSIS.tsv",header = T, sep = "\t")
endo <- endo$SYMBOL

lyso <- c(lyso,endo)


library(dplyr)
fibroblast <- read.csv("fibroblast_diff.csv",header = T)
findlyso1 <- fibroblast[which( fibroblast[,1]%in% lyso ),]
findlyso1 <- findlyso1  %>% filter(cohen > 0.2)

#write.csv(findlyso1, "fibroblast_all_enriched_lyso.csv")

library(dplyr)
induced <- read.csv("induced_neurons_diff.csv",header = T)
findlyso2 <- induced[which(induced[,1]%in% lyso ),]
findlyso2 <- findlyso2  %>% filter(cohen > 0.2)
#write.csv(findlyso2, "induced_neurons_all_enriched_lyso.csv")

library(dplyr)
stem <- read.csv("neuro_stem_cells_diff.csv",header = T)
findlyso3 <- stem[which( stem[,1]%in% lyso),]
findlyso3 <- findlyso3  %>% filter(cohen > 0.2)
#write.csv(findlyso3, "neuro_stem_cells_all_enriched_lyso.csv")


all<- read.csv("xdp_control_all_cells.csv",header = T)
findlyso4 <- all[which( all[,1]%in% lyso ),]
findlyso4 <- findlyso4  %>% filter(cohen > 0.2)
#write.csv(findlyso4, "all_cells_all_enriched_lyso.csv")

dff <- full_join(findlyso1[,c("gene","cohen")],findlyso2[,c("gene","cohen")], by = "gene")
colnames(dff)[2:3] <- c("cohen_fibroblast_eniched", "cohen_induced_neuron_enriched")
dff <- findlyso3[,c("gene","cohen")] %>% full_join(dff, by = "gene")
colnames(dff)[2] <- c("cohen_neuron_stem_cells_enriched")
dff <-  findlyso4[,c("gene","cohen")] %>% full_join(dff, by = "gene")
colnames(dff)[2] <- c("cohen_for_all_celltypes_in_xdp_enriched")

write.csv(dff, "Table_4.csv")


#x <- findlyso1
#y <- inner_join(findlyso2, findlyso3, by ='gene')
#write.csv(y, "lyso_in_neurons.csv")
#z <- inner_join(x, y, by ='gene')
#write.csv(z, "lyso_in_3_celltype.csv")

z <- inner_join(z , findlyso4, by ='gene')
write.csv(z, "lyso_in_everything.csv")

z <- inner_join(y , findlyso4, by ='gene')
write.csv(z, "lyso_in_neuron_andeverything.csv")

z <- inner_join(findlyso2 , findlyso4, by ='gene')
write.csv(z, "lyso_in_inducedneuron_andeverything.csv")

