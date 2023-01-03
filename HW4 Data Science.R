library(shiny)
library(datasets)
library(ggplot2)
mpgData <- mtcars
ui <- fluidPage(
  titlePanel("Homework: Building A Shiny App - Doğaç Keleş"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput("variable", "Variable:",
                  c("Cylinders" = "cyl",
                    "Transmission" = "am",
                    "Gears" = "gear")),
      checkboxInput("outliers", "Show outliers", TRUE)
      
    ),
    mainPanel(
      h3(textOutput("caption")),
      plotOutput("mpgPlot")
    )
  )
)

server <- function(input, output) {
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  output$caption <- renderText({
    formulaText()
  })
  output$mpgPlot <- renderPlot({
    ggplot(data=mpgData, aes(x=mpg)) + 
      geom_histogram(binwidth=4,col= "white", 
                     fill="steelblue",alpha = 1) + facet_wrap(~mpgData[[input$variable]], nrow = 3)
  })
}
shinyApp(ui, server)
