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
    
    linkage <- "ward.D2"
    
    t <- hclust(dist(m),method=linkage)
    fix <- fix[t$order,]
    a=as.character(abstract[4,1])
    a=as.integer(a)
    
    cut<-dynamicTreeCut::cutreeDynamic(dendro = t,distM=as.matrix(dist(m)),deepSplit = 4,minClusterSize = a,method = "hybrid")

    if (input$Abstracts =="CL") {
      cut[cut==6]<-5
    }
    
    annotation <- unlist(lapply(sort(unique(cut)), function(x) {
      if (x==0) {
        return ("Not clustered")
      }
      cluster <- fix[which(cut[t$order]==x),]
      allterms <- t(sapply(cluster[!is.na(cluster)], function(y) strsplit(y,"|",fixed=TRUE)[[1]],USE.NAMES=FALSE))
      ##the first parenthesis is the frequency of the word in the abstract
      #freq <- sapply(allterms[,2], function(x) {substring(strsplit(x,")")[[1]][1],2)})
      #freq<-as.integer(freq)
      ##all unique terms
      uniqueterms <- unique(allterms[,1])
      allterms[,1] <- gsub(" ","",allterms[,1])
      foo <- gsub(" ","",uniqueterms) ##needs to be a temp variable, because we need to use unique terms
      temp <- unlist(lapply(foo, function(z) length(which(z==allterms[,1]))))
      #temp <- unlist(lapply(uniqueterms, function(z) sum(freq[which(z==allterms[,1])])))
      ##grab top 2 frequent terms
      top<- sort(temp,decreasing = TRUE)
      
      first<-paste(uniqueterms[temp%in%top[1]],collapse=",")
      if (top[2]!=top[1]) {
        second<-paste(uniqueterms[temp%in%top[2]],collapse=",")
        return (paste(first,second,sep="/"))
      } else {
        return (first)
      }
      #return (paste(uniqueterms[which(top==temp)],collapse=", "))
    }))
    ##If there are branches that are unclustered, 0 is in the 1st index
    if (0%in% cut) {
      newcut <- annotation[cut+1] 
    } else {
      newcut <- annotation[cut] 
    }
    
    newcut <- matrix(newcut,dimnames=list(NULL,"Cluster"))
    iHeatmap(t(m),addOnInfo = d,colAnnote = newcut,ClustM =linkage,Rowv = FALSE,showHeat = FALSE,xaxis_height = 40)
  })
  
  output$hovered <- renderPrint(
    input$myChart_hover
  )
})


