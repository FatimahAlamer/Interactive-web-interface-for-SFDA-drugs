#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
HumanDrugs <- read_csv("HumanDrugs.csv")
select (HumanDrugs,-c(`Marketing Status`,`Scientific Name Arabic`,`Trade Name Arabic`,AtcCode2,`Product type`,`Manufacture Country...31`,`2Manufacture Name`)) ->Sdrugs

# Define UI for application that draws a histogram
ui <- fluidPage(
  h1("Interactive Table for SFDA drugs"),
  
  
  fluidRow(
    column(4,
           sliderInput(inputId = "RegYe", label = "Register Year",
                       min = 1980, max = 2021,
                       value = c(2010, 2020)),
    column(4,
           selectInput("man",
                       "manufacturer country:",
                       c("All",
                         unique(as.character(Sdrugs$`Manufacture Country...29`))))
    ),
    column(4,
           selectInput("Rout",
                       "Rout of adminstration:",
                       c("All",
                         unique(as.character(Sdrugs$AdministrationRoute))))
    )
  ),
  # Create a new row for the table.
  DT::dataTableOutput("table")
)

server <- function(input, output) {
  output$table <- DT::renderDataTable(DT::datatable({
    data <- Sdrugs
    if (input$man != "All") {
      data <- data[data$`Manufacture Country...29` == input$man,]
    }
    if (input$Rout != "All") {
      data <- data[data$AdministrationRoute == input$Rout,]
    }
  
    data
  }))
  
}


# Run the application 
shinyApp(ui = ui, server = server)
