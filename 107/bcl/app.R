library(shiny)
library(tidyverse)

bcl <- read.csv("~/Documents/STAT54X/547/107/bcl-data.csv")


# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Select your desired price range.",
                  min = 0, max = 100, value = c(15, 30), pre="$"),
      radioButtons("typeInput", "Select your desired beverage.",
                 choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                 selected = "WINE")
    ),
    mainPanel(
      plotOutput("price_hist"),
      tableOutput("bcl_data")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  bcl_filtered <- reactive(bcl %>% 
    filter(Price < input$priceInput[2],
           Price > input$priceInput[1],
           Type == input$typeInput))
  output$price_hist <- renderPlot({
      bcl_filtered() %>% 
      ggplot(aes(Price)) +
      geom_histogram()
  })
  output$bcl_data <- renderTable({
     bcl_filtered()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

