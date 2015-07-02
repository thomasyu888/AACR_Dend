shinyUI(fluidPage(

  
  
  headerPanel("AACR Abstract Clustering"),
#sidebarPanel()
  sidebarPanel(
    tags$style(type="text/css", ".shiny-text-output {font-size: 10px;}"),
    verbatimTextOutput('hovered')
  ),
  mainPanel(
    iHeatmapOutput('myChart')
  )
))
