library(iHeatmap)
library(shiny)
library(htmlwidgets)
library(synapseClient)
synapseLogin()


#aacrxls <- synGet("syn4229664")
# options(java.parameters = "-Xmx1000M")
# aacr <- readWorksheetFromFile(aacrxls@filePath,sheet="DOI_MAI")
# aacrMAI <- aacr[,grepl("MAI", colnames(aacr))]
# allterms <- sort(unique(unlist(apply(aacrMAI, 1, function(x){
#   lapply(x, function(y) strsplit(y,"|",fixed=TRUE)[[1]][1])
# }))))
# 
# M <- matrix(0, nrow=nrow(aacrMAI), ncol=length(allterms))
# for(i in 1:nrow(M)){
#   tmp <- aacrMAI[i,]
#   foo <- t(sapply(tmp[!is.na(tmp)], function(y) strsplit(y,"|",fixed=TRUE)[[1]],USE.NAMES=FALSE))
#   idxs <- which(allterms %in% foo[,1])
#   M[i,idxs] <- as.numeric(gsub("\\(|\\)","",foo[,2]))
# }
# 
# row.names(M) <- aacr$C_num
# 
# Annotations <- matrix(aacr$Title)
# colnames(Annotations) <- "Title"


