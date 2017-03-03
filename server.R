# server.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny server script
# 2016-01-23
 
# Libraries and options ####
#source('prediction.R')

library(shiny)

# Define application ####

shinyServer(function(input, output) {
  
  # Reactive statement for prediction function when user input changes ####
  predict <- reactive( {
    
    # Get input
    Text <- input$text
    input1 <-  textsplit(Text)[1, ]
    input2 <-  textsplit(Text)[2, ]
    nSuggestion <- input$slider
    
    # Predict
    predict <- predictword(input1, input2, n = nSuggestion)
  })
  
  # Output data table ####
  output$table <- renderDataTable(predict(),
                                 option = list(pageLength = 5,
                                             # lengthMenu = list(c(5, 10, 100), c('5', '10', '100')),
                                               columnDefs = list(list(visible = F, targets = 1)),
                                               searching = F
                                 )
  )
  
  # Output word cloud ####
  wordcloud_rep = repeatable(wordcloud)
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