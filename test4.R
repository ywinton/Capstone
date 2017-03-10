
# Get bigram tokens 
valid2 <- tokenphrase(valid, 2)
valid2 <- data_frame(Next = valid2) %>%
  separate(Next, c('word2', 'Next'), ' ')
# Put empty string as word1
valid2 <- mutate(valid2, word1 = rep("", nrow(valid2))) %>%
  select(word1, word2, Next)

# Get trigram tokens
valid3 = tokenphrase(valid, 3)
valid3 = data_frame(Next = valid3) %>%
  separate(Next, c('word1', 'word2', 'Next'), ' ')

#saveRDS(valid2, file = "C:/Users/ywint887094/Desktop/R/shiny/valid2.rds")
#saveRDS(valid3, file = "C:/Users/ywint887094/Desktop/R/shiny/valid3.rds")

#valid2 <- readRDS("C:/Users/ywint887094/Desktop/R/shiny/valid2.rds")
#valid3 <- readRDS("C:/Users/ywint887094/Desktop/R/shiny/valid3.rds")

# Calculate accuracy 

accu = function(x) {
  
  # Apply prediction function to each input line 
  y = mapply(predictword, x$word1, x$word2)
  
  # Calculate accuracy
  accuracy = sum(ifelse(x$Next %in% unlist(y), 1, 0) / length(y))
  
  # Return accuracy percentage
  return(accuracy)
}




# Get bigram tokens 
valid2 <- tokenphrase(valid, 2)
valid2 <- data_frame(Next = valid2) %>%
  separate(Next, c('word3', 'Next'), ' ')
# Put empty string as word1
valid2 <- mutate(valid2, word1 = rep("", nrow(valid2)),word2 = rep("", nrow(valid2))) %>%
  select(word1, word2,word3, Next)

# Get trigram tokens
valid3 = tokenphrase(valid, 3)
valid3 = data_frame(Next = valid3) %>%
  separate(Next, c('word2','word3','Next'), ' ')
# Put empty string as word1
valid3 = mutate(valid3, word1 = rep("", nrow(valid3))) %>%
  select(word1, word2,word3, Next)

# Get quadgram tokens
valid4 = tokenphrase(valid, 4)
valid4 = data_frame(Next = valid4) %>%
  separate(Next, c('word1', 'word2','word3', 'Next'), ' ')

# Calculate Accuracy 

  accu = function(x) {
  
  # Apply prediction function to each input line 
  y = mapply(predictword3, x$word1, x$word2,x$word3)
  
  # Calculate accuracy
  accuracy = sum(ifelse(x$Next %in% unlist(y), 1, 0) / length(y))
  
  # Return accuracy percentage
  return(accuracy)
}

 accu = function(x) {
  
  # Apply prediction function to each input line 
  y = mapply(predictword, x$word2, x$word3)
  
  # Calculate accuracy
  accuracy = sum(ifelse(x$Next %in% unlist(y), 1, 0) / length(y))
  
  # Return accuracy percentage
  return(accuracy)
}


# Results ####

# Rounding precision
accuRound = 2

# Accuracy using 1 previous word and 5 suggestions
nSuggestions = 5
accuOneFive = round(accu(valid2), accuRound)

# Accuracy using 1 previous word and 3 suggestions
#nSuggestions = 3
#accuOneThree = round(accu(valid2), accuRound)

# Accuracy using 1 previous word and 1 suggestion
#nSuggestions = 1
#accuOneOne = round(accu(valid2), accuRound)

# Accuracy using 2 previous words and 5 suggestions
nSuggestions = 5
accuTwoFive = round(accu(valid3), accuRound)

# Accuracy using 2 previous words and 3 suggestions
#nSuggestions = 3
#accuTwoThree = round(accu(valid3), accuRound)

nSuggestions = 5
accuThreeFive = round(accu(valid4), accuRound)

# Accuracy using 2 previous words and 1 suggestion
#nSuggestions = 1
#accuTwoOne = round(accu(valid3), accuRound)

# Summary table
accuSummary = data.frame(Suggest5 = c(accuThreeFive,accuTwoFive, accuOneFive),
 # Suggest3 = c(accuThreeThree, accuTwoThree, accuOneThree),
  #Suggest1 = c(accuTwoOne, accuOneOne),
  row.names = c('Previous3','Previous2', 'Previous1')
)
print(accuSummary)


