
library(dplyr)
library(wordcloud)
library(RColorBrewer)
library(tm)
library(RWeka)
library(quanteda)

# Clean input data and tokenize ####
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


  
  
  # Tokenize ####
  tokenphrase2 <- function(x, ngramSize = 1, simplify = T) {
   x<- corpus(unlist(segment(x, 'sentences')))
    # Do some regex magic with quanteda
    char_tolower(
            quanteda::tokenize(x,
                         removeNumbers = T,
                         removePunct = T,
                         removeSeparators = T,
                         removeTwitter = T,
                         ngrams = ngramSize,
                         concatenator = " ",
                         simplify = simplify
      ) 
    )
  }


# Split input text,clean and tokenize ####
textsplit <- function(x) {
  
  # if no input, input1 and input2 are empty
  if(x == "") {
    input1 <- data_frame(word = "")
    input2 <- data_frame(word = "")
  }
  # Clean and tokenize input
  if(length(x) >=1) {
    tx <- data_frame(word = tokenphrase(x))
    
  }
  # For single word entry, use as last word
  if (nrow(tx) == 1) {
    input1 <- data_frame(word = "")
    input2 <- tx
    
  # For non-single word entry, return last 2 works    
  }   else if (nrow(tx) > 1) {
    input1 <- tail(tx, 2)[1, ]
    input2 <- tail(tx, 1)
  }
  
  # Return processed inputs as data frame 
  inputs <- data_frame(words = unlist(rbind(input1,input2)))
  return(inputs)
}

# Predict Next Word with 1,2,3 gram libraries####

predictword <- function(x, y, n = 10) {
  
  # If no input, return top unigram words
  if(x == "" & y == "") {
   
   predict  <- select(df1, Next, freq)
    
  # Start wtih using trigram library, match first input word with word1 
  # and second input word with word2 in trigram library
   
  }   else if(x %in% df3$word1 & y %in% df3$word2) {
    predict <-  filter(df3,word1 %in% x & word2 %in% y) %>%
      select(Next, freq)
 
  # If not found in trigram library, switch to bigram library, match   
  # second input word with word1 in bigraam library
  }   else if(y %in% df2$word1) {
    predict <- filter(df2, word1 %in% y) %>%
      select(Next, freq)
    
  # If not found in both trigram and bigram libraries, return top unigram words
  }   else{
    predict <- select(df1, Next, freq)
  }
  
  # Return predicted words in a data frame
  return(predict[1:n, ])
}


# Split input text,clean and tokenize ####
textsplit2 <- function(x) {
  
  # if no input, input1 and input2 are empty
  if(x == "") {
    input1 <- data_frame(word = "")
    input2 <- data_frame(word = "")
    input3 <- data_frame(word = "")
  }
  # Clean and tokenize input
  if(length(x) >=1) {
    tx <- data_frame(word = tokenphrase(x))
    
  }
  # For single word entry, use as last word
  if (nrow(tx) == 1) {
    input1 <- data_frame(word = "")
    input2 <- data_frame(word = "")
    input3 <- tx

  }
  # For 2 word entry, use as last 2 words
  if (nrow(tx) == 2) {
    input1 <- data_frame(word = "")
    input2 <- tail(tx, 2)[1, ]
    input3 <- tail(tx, 1)
    
    # For non-single word entry, return last 3 works    
  }   else if (nrow(tx) > 2) {
    input1 <- tail(tx, 3)[1, ]
    input2 <- tail(tx, 2)
    input3 <- tail(tx, 1)
  }
  
  # Return processed inputs as data frame 
  inputs <- data_frame(words = unlist(rbind(input1,input2,input3)))
  return(inputs)
}


# Predict Next Word with 1,2,3,4 gram libraries####
predictword2 <- function(x, y, z, n = 10) {
  
  # If no input, return top unigram words
  if(x == "" & y == "" & z == "") {
    
    predict  <- select(df1, Next, freq)
    
    # Start wtih using trigram library, match first input word with word1 
    # and second input word with word2 in trigram library
    
  }   else if(x %in% df3$word1 & y %in% df3$word2) {
    predict <-  filter(df3,word1 %in% y & word2 %in% z) %>%
      select(Next, freq)
    
    # Start wtih using trigram library, match first input word with word1 
    # and second input word with word2 in trigram library
    
  }   else if(x %in% df4$word1 & y %in% df4$word2  & z %in% df4$word3) {
    predict <-  filter(df4,word1 %in% x & word2 %in% y & word3 %in% z) %>%
      select(Next, freq)
    
    # If not found in trigram library, switch to bigram library, match   
    # second input word with word1 in bigraam library
  }   else if(y %in% df2$word1) {
    predict <- filter(df2, word1 %in% z) %>%
      select(Next, freq)
    
    # If not found in both trigram and bigram libraries, return top unigram words
  }   else{
    predict <- select(df1, Next, freq)
  }
  
  # Return predicted words in a data frame
  return(predict[1:n, ])
}

# Predict Next Word with 1,2,3,4 gram libraries####
predictword3 <- function(x, y, z, n = 10) {
  
  # If no input, return top unigram words
  if(x == "" & y == "" & z == "") {
    
    predict  <- select(df1, Next, freq)
    
    
    # If not found in trigram library, switch to bigram library, match   
    # second input word with word1 in bigraam library
  }   else if(y %in% df2$word1) {
    predict <- filter(df2, word1 %in% z) %>%
      select(Next, freq)
    
    # Start wtih using trigram library, match first input word with word1 
    # and second input word with word2 in trigram library
    
  }   else if(x %in% df3$word1 & y %in% df3$word2) {
    predict <-  filter(df3,word1 %in% y & word2 %in% z) %>%
      select(Next, freq)
    
    # Start wtih using trigram library, match first input word with word1 
    # and second input word with word2 in trigram library
    
  }   else if(x %in% df4$word1 & y %in% df4$word2  & z %in% df4$word3) {
    predict <-  filter(df4,word1 %in% x & word2 %in% y & word3 %in% z) %>%
      select(Next, freq)
    
 
    
    # If not found in both trigram and bigram libraries, return top unigram words
  }   else{
    predict <- select(df1, Next, freq)
  }
  
  # Return predicted words in a data frame
  return(predict[1:n, ])
}


# Predict Next Word with 1,2,3,4 gram libraries####
predictword4 <- function(x, y, z, n = 10) {
  
  # If no input, return top unigram words
  if(x == "" & y == "" & z == "") {
    
    predict  <- select(df1, Next, freq)
  
      # If not found in trigram library, switch to bigram library, match   
    # second input word with word1 in bigraam library
  }   else if(y %in% df2$word1) {
    predict <- filter(df2, word1 %in% z) %>%
      select(Next, freq)
    # Start wtih using trigram library, match first input word with word1 
    # and second input word with word2 in trigram library
    
  }   else if(x %in% df3$word1 & y %in% df3$word2) {
    predict <-  filter(df3,word1 %in% y & word2 %in% z) %>%
      select(Next, freq)
    
    # Start wtih using trigram library, match first input word with word1 
    # and second input word with word2 in trigram library
    
  }   else if(x %in% df4$word1 & y %in% df4$word2  & z %in% df4$word3) {
    predict <-  filter(df4,word1 %in% x & word2 %in% y & word3 %in% z) %>%
      select(Next, freq)
    
  
    
    # If not found in both trigram and bigram libraries, return top unigram words
  }   else{
    predict <- select(df1, Next, freq)
  }
  
  # Return predicted words in a data frame
  return(predict[1:n, ])
}