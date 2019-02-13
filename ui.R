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
MonthNo,Month,AnsweredCallVolume,AnswerTime
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
  titlePanel("Measure Average Speed to Answer based on input call data in a specific Range"),
  
  
  # Sidebar with a slider input for months 
  sidebarLayout(
    sidebarPanel(
        helpText("Please choose the date range"),
        sliderTextInput(
        inputId = "MonthRange",
        label = "Month range slider:",
        choices = CallData$Month,
        selected = CallData[CallData$MonthNo[c(4, 7)],2]
        ),
        helpText("Based on Date Range selection Input data is:"),
        tableOutput("inputData")
    ),
    
    # Show a plot of the generated distribution
   mainPanel(
      # Create tab panes
      tabsetPanel(type="tab",
                  tabPanel("Output Data", tableOutput("displayData"),"This will show Data after caluclation Avg Speed to Ans(last column)"),
                  tabPanel("Output Plot", plotOutput("mygraph"),"This will show Avg Speed to answer trend")
      )
    )
  )
))
