#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyWidgets)

# Read Data

CallData <- read.csv(textConnection("
MonthNo,Month,Answered Call Volume,Answer Time
1,January,7140,86592
2,February,6226,88074
3,March,6649,104399
4,April,6474,120343
5,May,6796,116046
6,June,6219,118601
7,July,6203,144831
8,August,7334,123905
9,September,6300,163523
10,October,8665,198676
11,November,8615,340456
12,December,8737,219271
"))

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Measure Call Data in a specific Range"),
  
  # Sidebar with a slider input for months 
  sidebarLayout(
    sidebarPanel(
      sliderTextInput(
        inputId = "MonthRange",
        label = "Month range slider:",
        choices = CallData$Month,
        selected = CallData[CallData$MonthNo[c(4, 7)],2]
        )
    ),
    
    # Show a plot of the generated distribution
   mainPanel(
      # Create tab panes
      tabsetPanel(type="tab",
                  tabPanel("Data", tableOutput("displayData")),
                  tabPanel("Plot", plotOutput("mygraph"))
      )
    )
  )
))
