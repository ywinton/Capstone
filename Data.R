
# Libraries and options ####
source('shiny/prediction.R')
library(caTools)
library(tidyr)
library(tm)
library(RWeka)
library(quanteda)

# Read data sets
blogs <-  readLines("C:/Users/ywint887094/Desktop/R/shiny/en_US.blogs.txt")
news <-   readLines("C:/Users/ywint887094/Desktop/R/shiny/en_US.news.txt")
twitter <-  readLines("C:/Users/ywint887094/Desktop/R/shiny/en_US.twitter.txt")

#blogs <-  readLines("shiny/en_US.blogs.txt")
#news <-   readLines("shiny/en_US.news.txt")
#twitter <-  readLines("shiny/en_US.twitter.txt")
combined <- c(blogs, news, twitter)

# Combine and sample data
set.seed(1900)
n = 1/300
samplecombo <- sample(combined, length(combined) * n)

# Split data into training and validation sets
split <- sample.split(samplecombo, 0.2)
train <- subset(samplecombo, split == T)
valid <- subset(samplecombo, split == F)


#train <- corpus(unlist(segment(train, 'sentences')))
# Tokenize training set
Unigram  <- tokenphrase(train, 1)
bigram   <- tokenphrase(train, 2)
trigram  <- tokenphrase(train, 3)
quadgram <- tokenphrase(train, 4)

# Order top frequency words for each gram library####
freq <- function(x) {
  x <- group_by(x, Next) %>%
    summarize(freq = n()) #%>%
  x <- arrange(x,-freq)
}

df1 <- data_frame(Next = Unigram)
df1 <- freq(df1)

df2 <- data_frame(Next = bigram)
df2 <- freq(df2) %>%
  separate(Next, c('word1', 'Next'), " ")

df3 <- data_frame(Next = trigram)
df3 <- freq(df3) %>%
  separate(Next, c('word1', 'word2', 'Next'), " ")

df4 <- data_frame(Next = quadgram)
df4 <- freq(df4) %>%
  separate(Next, c('word1', 'word2', 'word3', 'Next'), " ")

# Save gram libraries ####
#saveRDS(df1, file = "C:/Users/ywint887094/Desktop/R/shiny/df1.rds")
#saveRDS(df2, file = "C:/Users/ywint887094/Desktop/R/shiny/df2.rds")
#saveRDS(df3, file = "C:/Users/ywint887094/Desktop/R/shiny/df3.rds")
#saveRDS(df4, file = "C:/Users/ywint887094/Desktop/R/shiny/df4.rds")

#df1 <-readRDS("C:/Users/ywint887094/Desktop/R/shiny/10pct/df1.rds")
#df2 <-readRDS("C:/Users/ywint887094/Desktop/R/shiny/10pct/df2.rds")
#df3 <-readRDS("C:/Users/ywint887094/Desktop/R/shiny/10pct/df3.rds")
#df4 <-readRDS("C:/Users/ywint887094/Desktop/R/shiny/10pct/df4.rds")
