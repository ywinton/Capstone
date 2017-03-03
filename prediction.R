# prediction.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Script for predicting a NextWord given an input of any length using stupid backoff algorithm
# 2016-01-23

# Libraries and options ####
library(dplyr)
library(wordcloud)
library(RColorBrewer)

library(tm)
library(RWeka)

# Transfer to quanteda corpus format and segment into sentences
#fun.corpus = function(x) {
#  corpus(unlist(segment(x, 'sentences')))
#}

# Tokenize ####
#fun.tokenize = function(x, ngram = 1, simplify = T) {
  
  # Do some regex magic with quanteda
#  char_tolower(
#    quanteda::tokenize(x,
#                       removeNumbers = T,
#                       removePunct = T,
#                       removeSeparators = T,
#                       removeTwitter = T,
#                       ngrams = ngram,
#                       concatenator = " ",
#                       simplify = simplify
#    ) 
#  )
#}


# Tokenize ####
tokenphrase <- function(x,ngram=1) {
  
  x <- gsub("&amp", "", x)
  x <- gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", x)
  x <- gsub("@\\w+", "",x)
  x <- gsub("[[:punct:]]", "", x)
  x <- gsub("[[:digit:]]", "", x)
  x <- gsub("http\\w+", "", x)
  x <- gsub("[ \t]{2,}", "", x)
  x <- gsub("^\\s+|\\s+$", "", x)
  
  corpus <- VCorpus(VectorSource(x), readerControl = list(language = "English"))
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, content_transformer(tolower))
  fdt<-data.frame(text=unlist(sapply(corpus, `[`, "content")),stringsAsFactors=F)
  tokenizer <-NGramTokenizer(fdt, Weka_control(min = ngram, max = ngram))

}


# Parse tokens from input text ####

textsplit <- function(x) {
  
  # If empty input, put both words empty
  if(x == "") {
    input1 <- data_frame(word = "")
    input2 <- data_frame(word = "")
  }
  # Tokenize with same functions as training data
  if(length(x) ==1) {
    tx <- data_frame(word = tokenphrase(x))
    
  }
  # If only one word, put first word empty
  if (nrow(tx) == 1) {
    input1 <- data_frame(word = "")
    input2 <- tx
    
    # Get last 2 words    
  }   else if (nrow(tx) > 1) {
    input1 <- tail(tx, 2)[1, ]
    input2 <- tail(tx, 1)
  }
  
  #  Return data frame of inputs 
  inputs <- data_frame(words = unlist(rbind(input1,input2)))
  return(inputs)
}

# Predict using stupid backoff algorithm ####


predictword <- function(x, y, n = 10) {
  
  # Predict giving just the top 1-gram words, if no input given
  if(x == "" & y == "") {
   
   predict  <- select(df1, Next, freq)
    
    # Predict using 3-gram model
  }   else if(x %in% df3$word1 & y %in% df3$word2) {
    predict <-  filter(df3,word1 %in% x & word2 %in% y) %>%
      select(Next, freq)
    
    # Predict using 2-gram model
  }   else if(y %in% df2$word1) {
    predict <- filter(df2, word1 %in% y) %>%
      select(Next, freq)
    
    # If no prediction found before, predict giving just the top 1-gram words
  }   else{
    predict <- select(df1, Next, freq)
  }
  
  # Return predicted word in a data frame
  return(predict[1:n, ])
}