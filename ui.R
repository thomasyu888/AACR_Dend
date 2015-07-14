shinyUI(fluidPage(

  headerPanel("AACR Abstract Clustering"),
#sidebarPanel()
  sidebarPanel(
    tags$style(type="text/css", ".shiny-text-output {font-size: 8px;}"),
    selectInput("Abstracts", "Choose an abstract:",
                choices = c("AM","CL", "ET", "MCB","MCB10","TB"),selected="CL"),
   # numericInput("Cluster", "Cut tree height (0-1):", 843,
    #             min = 0, max = 867),
    #sliderInput("Cluster", "Cluster amount: ", min= 0, max=10, 1,step=1),
    selectInput("Linkage","Choose a clustering method:",
                ##single/median/centroid doesn't work or some reason...
                choices = c(#"single", 
                            "complete", 
                            "average", 
                            "mcquitty", 
                            "ward.D2",
                            "ward.D"
                            #"centroid",
                            #"median"
                            ),selected="ward.D2")#,
   #conditionalPanel(condition="$('html').hasClass('shiny-busy')",
    #                tags$div("Loading...",id="loadmessage")
#   )
   # verbatimTextOutput('hovered')
    

  ),
  mainPanel(
    iHeatmapOutput('myChart'),
    tabsetPanel(
     # tabPanel("Plot", plotOutput("plot")),
      tabPanel("Summary", verbatimTextOutput('hovered'))
     # tabPanel("Table", tableOutput("table"))
    )
    
  )
))
