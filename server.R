# server.R ####
# Coursera Data Science Capstone Project 
# 2017-2-26


# Libraries ####

source('prediction.R')
library(dplyr)
library(wordcloud)
library(RColorBrewer)
library(tm)
library(RWeka)
library(quanteda)
library(shiny)

# Shiny App ####

shinyServer(function(input, output) {
  
  # Reactive statement for prediction function when user input changes ####
  predict <- reactive( {
    
    # Get input
    Text <- input$text
    input1 <-  textsplit(Text)[1, ]
    input2 <-  textsplit(Text)[2, ]
   #input3 <-  textsplit2(Text)[3, ]

    nSuggestion <- input$slider
    
    # Predict
    predict <- predictword(input1, input2, n = nSuggestion)
  })
  
  # Output data table ####
  output$table <- renderDataTable(predict(),
                                  option = list(pageLength = 10,
                                                # lengthMenu = list(c(5, 10, 100), c('5', '10', '100')),
                                                columnDefs = list(list(visible = F, targets = 1)),
                                                searching = F
                                  )
  )
  
  
  
  # Output word cloud ####
  wordcloud_rep = repeatable(wordcloud)
  # is.na(predict()$Next) <- 0
  output$wordcloud <- renderPlot(
    wordcloud_rep(
      predict()$Next,
      predict()$freq,
      colors = brewer.pal(8, 'Dark2'),
      scale=c(4, 0.5),
      max.words = 300
    )
  )
})