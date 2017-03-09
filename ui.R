# ui.R ####
# Shiny UI script
# 2017-2-26

library(shiny)


shinyUI
(
  fluidPage
  (theme =  "united.css",
    
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
                    min = 0,  max = 20,  value = 8
        ),
        
        # Table output
        dataTableOutput('table')),
      
      # Mainpanel ####
      
      mainPanel(
        
        wellPanel(
          
          # Details on app
          helpText(a('Information on the app',
                     href='http://rpubs.com/ywinton/255957', 
                     target = '_blank')
          ),
          
          # Link to repo
          helpText(a('Code repository',
                     href='https://github.com/ywinton/Capstone',
                     target = '_blank')
          ),
          
          # Wordcloud output
          plotOutput('wordcloud')
        )
      ) 
    )
  )
)