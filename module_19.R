library(shiny)

setwd("C:/Users/alimb/OneDrive/Рабочий стол/test")
titanic_data <- read.csv("Titanic.csv")

ui <- fluidPage(
  titlePanel("Titanic Passengers"),
  fluidRow(
    column(6, 
           selectInput("nonquant", "Barplot:", 
                       choices = c("Survived", "Pclass", "Sex"), 
                       selected = "Survived")
    ),
    column(6, 
           selectInput("quant", "Histogram:", 
                       choices = c("Age", "Fare"), 
                       selected = "Age")
    )
  ),
  
  fluidRow(
    column(6, 
           selectInput("color1", "Color 1:", 
                       choices = c("Red", "Blue", "Green", "Orange", "Purple"), 
                       selected = "Red")
    ),
    column(6, 
           selectInput("color2", "Color 2:", 
                       choices = c("Hotpink", "Yellow", "Cyan", "Grey", "Pink"), 
                       selected = "Hotpink")
    )
  ),
  
  fluidRow(
    splitLayout(cellWidths = c("50%", "50%"),
                plotOutput("distPlot1"),
                plotOutput("distPlot2"))
  )
)

server <- function(input, output) {
  output$distPlot1 <- renderPlot({
    bar_data <- table(titanic_data[[input$nonquant]])
    bar_colors <- input$color1
    
    barplot(
      bar_data,
      main = paste("Barplot of", input$nonquant),
      xlab = input$nonquant,
      ylab = "Count",
      col = bar_colors,
      border = "black",
      ylim = c(0, max(bar_data))
    )
  })
  
  output$distPlot2 <- renderPlot({
    hist_data <- na.omit(titanic_data[[input$quant]])
    hist_colors <- input$color2
    
    hist(
      hist_data,
      main = paste("Histogram of", input$quant),
      xlab = input$quant,
      ylab = "Frequency",
      col = hist_colors,
      border = "blue",
      breaks = 11
    )
  })
}

shinyApp(ui = ui, server = server)