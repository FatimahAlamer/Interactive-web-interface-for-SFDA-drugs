#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.

library(shiny)
library(shinythemes)

HumanDrugs <- read_csv("HumanDrugs.csv")
select (HumanDrugs,-c(`Marketing Status`,`Scientific Name Arabic`,`Trade Name Arabic`,AtcCode2,`Product type`,`Manufacture Country...31`,`2Manufacture Name`)) ->Sdrugs


 # define UI
ui <- fluidPage(theme = shinytheme("cerulean"),
 navbarPage(title = "SFDA Drugs",
             tabPanel(title = "Interactive Table for SFDA drugs",
  fluidRow(
    sliderInput(inputId = "RegYe", "Register Year",
                min = 1980, max = 2021,
                value = c(2010, 2020)),
    
           column(3,
                  selectInput("man",
                              "manufacturer country:",
                              c("All",
                                unique(as.character(Sdrugs$`Manufacture Country...29`))))
           ),
           column(3,
                  selectInput("Rout",
                              "Rout of adminstration:",
                              c("All",
                                unique(as.character(Sdrugs$AdministrationRoute))))
           ),
    column(2,
           selectInput("Type",
                       "Drug Type:",
                       c("All",
                         unique(as.character(Sdrugs$DrugType))))
    ),
    column(2,
           selectInput("Sub",
                       "Drug Sub-type:",
                       c("All",
                         unique(as.character(Sdrugs$`Sub-Type`))))
    )
    ),
    # Create a new row for the table.
    DT::dataTableOutput("table")
  ),
  tabPanel("Country map for drugs"),
  tabPanel("Paracetamol Calculator"),
  tabPanel("About")
 )
)
  server <- function(input, output) {
    output$table <- DT::renderDataTable(DT::datatable({
      data <- Sdrugs
      
      data <- subset(
        data,
        RegisterYear >= input$RegYe[1] & RegisterYear <= input$RegYe[2]
      )
      if (input$man != "All") {
        data <- data[data$`Manufacture Country...29` == input$man,]
      }
      if (input$Rout != "All") {
        data <- data[data$AdministrationRoute == input$Rout,]
      }
      if (input$Sub != "All") {
       
        data <- `Sub-Type` %>% 
          filter(`Sub-Type`  == input$Sub)
        #select() %>%  filter(!is.na(`Sub-Type` ), 
      }
      if (input$Type != "All") {
        data <- data[data$DrugType  == input$Type,]
      }
      
      data
    }))
    
  }
  
  
  # Run the application 
  shinyApp(ui = ui, server = server)
  