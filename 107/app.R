library(shiny)

bcl <- read.csv("~/Documents/STAT54X/547/107/bcl-data.csv")


# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel("hi i'm a side panel"),
    mainPanel(
      plotOutput("price_hist"),
      tableOutput("bcl_data")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$price_hist <- renderPlot(ggplot2::qplot(bcl$Price))
  output$bcl_data <- renderTable(bcl)
}

# Run the application 
shinyApp(ui = ui, server = server)

