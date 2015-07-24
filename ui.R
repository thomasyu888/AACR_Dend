shinyUI(fluidPage(

  headerPanel("AACR Abstract Clustering"),
#sidebarPanel()
  sidebarPanel(
    tags$style(type="text/css", ".shiny-text-output {font-size: 8px;}"),
    selectInput("Abstracts", "Choose an abstract:",
                choices = c("AM","CL", "ET", "MCB","MCB10","TB","sage_AM",
                            "sage_CL","sage_ET","sage_MCB","sage_TB"),selected="CL")
  
   #conditionalPanel(condition="$('html').hasClass('shiny-busy')",
    #                tags$div("Loading...",id="loadmessage")
#   )
   
  
  ),
  mainPanel(
    iHeatmapOutput('myChart'),
    tabsetPanel(
     
      tabPanel("Summary", verbatimTextOutput('hovered'))
     
    )
    
  )
))
