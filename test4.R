
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

# Accuracy using 1 previous word and 5 suggestions
nSuggestions = 5
oneaccu5 = round(accu(valid2), 2)

# Accuracy using 1 previous word and 3 suggestions
#nSuggestions = 3
#oneaccu3 = round(accu(valid2), 2)

# Accuracy using 1 previous word and 1 suggestion
#nSuggestions = 1
#oneaccu1 = round(accu(valid2), 2)

# Accuracy using 2 previous words and 5 suggestions
nSuggestions = 5
twoaccu5 = round(accu(valid3), 2)

# Accuracy using 2 previous words and 3 suggestions
#nSuggestions = 3
#twoaccu3 = round(accu(valid3), 2)

nSuggestions = 5
threeaccu5 = round(accu(valid4), 2)

# Accuracy using 2 previous words and 1 suggestion
#nSuggestions = 1
#twoaccu1 = = round(accu(valid3), 2)

# Summary table
accuracy_sum = data.frame(Suggest5 = c(threeaccu5,twoaccu5 , oneaccu5),
 # Suggest3 = c(threeaccu3,twoaccu3, oneaccu3),
  #Suggest1 = c(threeaccu1,twoaccu1 , oneaccu1),
  row.names = c('Previous3','Previous2', 'Previous1')
)
print(accuracy_sum)


