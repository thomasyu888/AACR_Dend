shinyServer(function(input, output) {
  output$myChart <- renderIHeatmap({
    iHeatmap(t(M),colAnnote = Annotations,ClustM ="ward.D2",Rowv = FALSE, showHeat = FALSE,width=600)
  })
})
