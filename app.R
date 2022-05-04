#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
  
    #GIT - EDITAR TITULO DE LA APLICACION ###################################
    titlePanel("Iris Database: Classification with Random Forest (v2.2)"),
    #########################################################################

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(width=3,
            sliderInput("bins",
                        "Paramater:",
                        min = 1,
                        max = 30,
                        value = 10),
            
            #GIT - AGREGAR SLIDER PARA PROPORCION DE DATOS DE ENTRENAMIENTO ###
            sliderInput("prop",
                        "% de entrenamiento:",
                        min = 50,
                        max = 90,
                        value = 80),
            ##################################################################
            
            #GIT - EDITAR TITULO DEL BOTON ###################################
            actionButton("do", "Classify")
            ##################################################################
            ),
        
        
        # Show a plot of the generated distribution
        mainPanel(
            'Data Visualization of Training Samples',
            fluidRow(
                column(10,offset=1,
                      plotOutput("trainPlot",width = "100%", height = "350px")
                )
            ),
            'Classification Results',
           fluidRow(
               column(10,offset=1,
                      plotOutput("testPlot",width = "100%", height = "350px")
               )
           )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    observeEvent(input$do, {
        
        PAR    <<- input$bins
        
        #GIT - OBTENER VALOR DEL SLIDER DE PROPORCION DE ENTRENAMIENTO ####
        PTRAIN <<- 0.01*input$prop
        ###################################################################
        
        #Principal component analysis
        source("pca.R")
        
        #Classification with random forests
        source("classification.R")
        
        #Generate graphs
        source("graph.R")
        
        #Update training graph
        output$trainPlot <- renderPlot({
            g2
        })
        
        #Update test graph
        output$testPlot <- renderPlot({
            g3
        })
    })
    
    
    
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
