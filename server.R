shinyServer(function(input, output) {
  output$myChart <- renderIHeatmap({
    iHeatmap(m,ClustM ="ward.D2",Rowv = FALSE,showHeat = FALSE, width=600)
    #iHeatmap(t(M),Colv = FALSE, ClustM ="ward.D2",Rowv = FALSE,width=600)  
    })
})
