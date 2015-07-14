library(synapseClient)
shinyServer(function(input, output) {
  output$myChart <- renderIHeatmap({
    
    
    abstract <- total[input$Abstracts]
    dat <- synGet(as.character(abstract[1,1]))
    annot <- synGet(as.character(abstract[2,1]))
    tem <- synGet(as.character(abstract[3,1]))
    
    m<- read.delim(dat@filePath,sep="\t")
    d<- read.delim(annot@filePath,sep="\t")
    fix <- read.table(tem@filePath,sep="\t")
    
    linkage <- input$Linkage
    
    t <- hclust(dist(m),method=linkage)
    fix <- fix[t$order,]
    a=as.character(abstract[4,1])
    a=as.integer(a)
    
    cut<-dynamicTreeCut::cutreeDynamic(dendro = t,distM=as.matrix(dist(m)),deepSplit = 4,minClusterSize = a,method = "hybrid")
    #while (0 %in% cut) {
    #  a=a-1
     # cut<-dynamicTreeCut::cutreeDynamic(dendro = t,distM=as.matrix(dist(m)),deepSplit = 4,minClusterSize = a,method = "hybrid")
    #}
    annotation <- unlist(lapply(sort(unique(cut)), function(x) {
      cluster <- fix[which(cut[t$order]==x),]
      allterms <- unlist(apply(cluster, 1, function(m){
        lapply(m, function(o) strsplit(o,"|",fixed=TRUE)[[1]][1])
      }))
      uniqueterms <- unique(allterms)
      #get rid of all the spaces
      allterms <- gsub(" ","",allterms)
      foo <- gsub(" ","",uniqueterms) ##needs to be a temp variable, because we need to use unique terms
      temp <- unlist(lapply(foo, function(z) length(which(z==allterms))))
      top<- sort(temp,decreasing = TRUE)[1:2]
      #return (paste(uniqueterms[which(top==temp)],collapse=", "))
      return (paste(uniqueterms[temp%in%top],collapse=", "))
    }))
    ## for when there are things not clustered by dynamic clustering
    #annotation <- c(annotation,"none")
    # cut[cut==0]=length(unique(cut))
    newcut <- annotation[cut]
    
    # print(unique(newcut))
    #print(max(table(newcut)))
    #print(sum(table(newcut)<7))
    #print(length(unique(cut)))
    #print(max(cut))
    #print(length(table(newcut)))
    #print(table(cut))
    
    newcut <- matrix(newcut,dimnames=list(NULL,"Cluster"))
    iHeatmap(t(m),addOnInfo = d,colAnnote = newcut,ClustM =linkage,Rowv = FALSE,showHeat = FALSE,xaxis_height = 40)
  })
  
  output$hovered <- renderPrint(
    input$myChart_hover
  )
})


