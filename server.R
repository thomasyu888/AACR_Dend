library(synapseClient)
shinyServer(function(input, output) {
  output$myChart <- renderIHeatmap({
    iHeatmap(t(m),addOnInfo = d,colAnnote = newcut, ClustM ="ward.D2",Rowv = FALSE,showHeat = FALSE, width=600)
    })
})



