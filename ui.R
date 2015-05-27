shinyUI(fluidPage(
  headerPanel("Interactive Dendrogram"),
#sidebarPanel()
  mainPanel(
    iHeatmapOutput('myChart')
  )
))
