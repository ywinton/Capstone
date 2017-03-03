# ui.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny UI script
# 2016-01-23

# Libraries and options ####
library(shiny)
#library(shinythemes)

# Define the app ####

shinyUI(fluidPage(
  
  # Theme
  #theme = shinytheme("flatly"),
  
  # Application title
  titlePanel("Word Predictor"),
  
  # Sidebar ####    
  sidebarLayout(
    
    sidebarPanel(
      
      # Text input
      textInput("text", label = ('Your Input Text'), value = ''),
      
      # Number of words slider input
      sliderInput('slider',
                  'Number of suggested words',
                  min = 0,  max = 10,  value = 5
      ),
      
      # Table output
      dataTableOutput('table')),
    
    # Mainpanel ####
    
    mainPanel(
      
      wellPanel(
        
        # Link to report
        helpText(a('More information on the app',
                   href='what', 
                   target = '_blank')
        ),
        
        # Link to repo
        helpText(a('Code repository',
                   href='what',
                   target = '_blank')
        ),
        
        # Wordcloud output
        plotOutput('wordcloud')
      )
    ) 
  )
)
)