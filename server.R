shinyServer(function(input, output) {
  output$myChart <- renderIHeatmap({
  
    data <- synGet("syn4260715")
    annot <- synGet("syn4260703")
    m<- read.delim(data@filePath,sep="\t")
    m <- as.matrix(m)
    d<- read.table(annot@filePath,sep="\t")
    d <- as.matrix(d)
    iHeatmap(m,colAnnote = d,ClustM ="ward.D2",Rowv = FALSE,showHeat = FALSE, width=600)
    #iHeatmap(t(M),Colv = FALSE, ClustM ="ward.D2",Rowv = FALSE,width=600)  
    })
})
