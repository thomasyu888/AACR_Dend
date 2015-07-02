shinyUI(fluidPage(

  
  
  headerPanel("AACR Abstract Clustering"),
#sidebarPanel()
  sidebarPanel(

      h6(verbatimTextOutput('hovered')),width=4
  ),
  mainPanel(
    iHeatmapOutput('myChart')
  )
))
