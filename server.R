library(synapseClient)
shinyServer(function(input, output) {
  output$myChart <- renderIHeatmap({
    iHeatmap(t(m),addOnInfo = d,colAnnote = newcut,ClustM ="ward",legend_width = 100,Rowv = FALSE,showHeat = FALSE, width=600)
    })
  output$hovered <- renderPrint(
    input$myChart_hover
  )
})



