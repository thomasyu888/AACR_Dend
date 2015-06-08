library(iHeatmap)
library(shiny)
library(htmlwidgets)
library(synapseClient)
synapseLogin()
dat <- synGet('syn4260756')
annot <- synGet("syn4260757")
m<- read.delim(dat@filePath,sep="\t")
d<- read.delim(annot@filePath,sep="\t")

h<- hclust(dist(m),method="ward.D2")
cut <- cutree(h,k=20)
annotation <- unlist(lapply(unique(cut), function(x) {
  cluster <- fixed[which(cut[h$order]==x),]
  allCone <- unique(unlist(apply(cluster, 1, function(j){
    lapply(j, function(y) strsplit(y,"|",fixed=TRUE)[[1]][1])
  })))
  dog <- unlist(cluster)
  dog <- unlist(lapply(dog, function(d) strsplit(d,"|",fixed=TRUE)[[1]][1]))
  dog <- gsub(" ","",dog)
  foo <- gsub(" ","",allCone)
  temp <- unlist(lapply(foo, function(z) length(which(z==as.matrix(dog)))))
  return (allCone[which(max(temp)==temp)])
}))
newcut <- annotation[cut]
newcut <- matrix(newcut,dimnames=list(NULL,"Cluster"))
