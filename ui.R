shinyUI(fluidPage(

  headerPanel("AACR Abstract Clustering"),
#sidebarPanel()
  sidebarPanel(
    tags$style(type="text/css", ".shiny-text-output {font-size: 8px;}"),
    selectInput("Abstracts", "Choose an abstract:",
                choices = c("AM","CL", "ET", "MCB","TB"),selected="AM"),
    verbatimTextOutput('hovered')

  ),
  mainPanel(
    iHeatmapOutput('myChart')
  )
))
