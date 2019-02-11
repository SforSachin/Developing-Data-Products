#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)

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


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # prepare data based on input data
    myFinalData <- reactive({
    myData<-CallData[CallData$MonthNo[which(CallData$Month == input$MonthRange[1])]:CallData$MonthNo[which(CallData$Month == input$MonthRange[2])],]

    data.frame(myData %>%  mutate(AvgSpeedToAns=as.integer(myData$Answer.Time/myData$Answered.Call.Volume)) )
  })
  
  # Prepare "Data tab"
  output$displayData <- renderTable({
    myFinalData()
  })
  
  output$mygraph <- renderPlot({
    
    myData1<-myFinalData()
    myData1 <- within(myData1,Month <- factor(Month, levels = month.name))
    x <- myData1[, 2] 
    y <- myData1[, 5]
    
    # draw the plot with the specified number of months
    plot(x,y,xlab='Months',ylab = 'Avg speed to Ans(sec)')
    
  })

  
  
})
