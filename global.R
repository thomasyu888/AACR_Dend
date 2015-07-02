library(iHeatmap)
library(shiny)
library(htmlwidgets)
library(synapseClient)

synapseLogin()
dat <- synGet('syn4260756')
annot <- synGet("syn4260757")
tem <- synGet("syn4382386")
m<- read.delim(dat@filePath,sep="\t")
d<- read.delim(annot@filePath,sep="\t")
fix <- read.table(tem@filePath,sep="\t")

h<- hclust(dist(m),method="ward")
cut <- cutree(h,k=50)
fix <- fix[h$order,]

annotation <- unlist(lapply(unique(cut), function(x) {
  cluster <- fix[which(cut[h$order]==x),]
  allCone <- unique(unlist(apply(cluster, 1, function(j){
    lapply(j, function(y) strsplit(y,"|",fixed=TRUE)[[1]][1])
  })))
  dog <- unlist(apply(cluster, 1, function(m){
    lapply(m, function(o) strsplit(o,"|",fixed=TRUE)[[1]][1])
  }))
  dog <- gsub(" ","",dog)
  foo <- gsub(" ","",allCone)
  temp <- unlist(lapply(foo, function(z) length(which(z==dog))))
  return (allCone[which(max(temp)==temp)])
}))

newcut <- annotation[cut]
newcut <- matrix(newcut,dimnames=list(NULL,"Cluster"))
