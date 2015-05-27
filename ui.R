shinyUI(fluidPage(
  headerPanel("AACR Abstract Clustering"),
#sidebarPanel()
  mainPanel(
    iHeatmapOutput('myChart')
  )
))
