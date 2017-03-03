# prepare_data.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Prepare data for downstream analysis and models
# 2015-12-20

# Libraries and options ####
source('shiny/prediction.R')

#library(readr)
library(caTools)
library(tidyr)
library(tm)
library(RWeka)

# Read and prepare data ####

# Read in data
blogs <-  readLines("C:/Users/ywint887094/Desktop/R/en_US/en_US.blogs.txt")
news <-   readLines("C:/Users/ywint887094/Desktop/R/en_US/en_US.news.txt")
twitter <-  readLines("C:/Users/ywint887094/Desktop/R/en_US/en_US.twitter.txt")
combined <- c(blogs, news, twitter)

# Sample and combine data  
set.seed(1900)
n = 1/100
samplecombo <- sample(combined, length(combined) * n)

# Split into train and validation sets
split <- sample.split(samplecombo, 0.8)
train <- subset(samplecombo, split == T)
valid <- subset(samplecombo, split == F)

# Tokenize ####


# Transfer to quanteda corpus format and segment into sentences (prediction.R)
#train = corpus(unlist(segment(train, 'sentences')))

# Tokenize (prediction.R)
Unigram  <- tokenphrase(train, 1)
bigram   <- tokenphrase(train, 2)
trigram  <- tokenphrase(train, 3)

# Frequency tables ####
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
# Save Data ####
#saveRDS(df1, file = "C:/Users/ywint887094/Desktop/R/df1.rds")
#saveRDS(df2, file = "C:/Users/ywint887094/Desktop/R/df2.rds")
#saveRDS(df3, file = "C:/Users/ywint887094/Desktop/R/df3.rds")
#df1 <-readRDS("C:/Users/ywint887094/Desktop/R/df1.rds")
#df2 <-readRDS("C:/Users/ywint887094/Desktop/R/df2.rds")
#df3 <-readRDS("C:/Users/ywint887094/Desktop/R/df3.rds")
