library(synapseClient)
shinyServer(function(input, output) {
  output$myChart <- renderIHeatmap({
    
    total <- data.frame(AM = c('syn4260756','syn4260757','syn4382386'),
                        CL = c('syn4588477','syn4588476','syn4588478'), 
                        ET = c('syn4588480','syn4588479','syn4588481'), 
                        MCB= c('syn4588483','syn4588482','syn4588484'),
                        TB = c('syn4588486','syn4588485','syn4588487'))
    abstract <- total[input$Abstracts]

    dat <- synGet(as.character(abstract[1,1]))
    annot <- synGet(as.character(abstract[2,1]))
    tem <- synGet(as.character(abstract[3,1]))
    m<- read.delim(dat@filePath,sep="\t")
    d<- read.delim(annot@filePath,sep="\t")
    fix <- read.table(tem@filePath,sep="\t")
    
    h<- hclust(dist(m),method="ward")
    #cut <- cutree(h,k=50)
    fix <- fix[h$order,]
    cut<-dynamicTreeCut::cutreeDynamic(dendro = h,distM=as.matrix(dist(m)),maxCoreScatter = 0.99, minGap = (0.01*0.75),minClusterSize = 1,deepSplit=4,method = "hybrid")
    
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
      return (paste(allCone[which(max(temp)==temp)],collapse=", "))
    }))
    
    newcut <- annotation[cut]
    newcut <- matrix(newcut,dimnames=list(NULL,"Cluster"))
    
    iHeatmap(t(m),addOnInfo = d,colAnnote = newcut,ClustM ="ward",legend_width = 0,Rowv = FALSE,showHeat = FALSE, width=600)
    })
  output$hovered <- renderPrint(
    input$myChart_hover
  )
})



