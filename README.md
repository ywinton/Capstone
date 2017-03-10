## Coursera Capstone Project
This project is part of Coursera data science course by Johns Hopkins University in partnership with SwiftKey. The goal is to clean and analyze a large corpus of unstructured text and build a word prediction app.

Word Prediction app:  
https://ywpublic.shinyapps.io/PredictWord/

##How to Use 

- Please open app and wait up to 30 seconds.
- When slider for number of words appears, app is ready.
- Please enter input text.

## Data Source

The data sources are text files gathered from Twitter, blogs and news sources, collected by a web crawler.  Due to the enormous size of dataset, 10% of the raw data was finally used to build a prediction model. Unigram, bigram, trigram and quadgram libraries were built.  Training and prediction sets were split 80-20. The last 2 or 3 words of the input phrase were extracted for prediction. 2 different prediction models were considered:

- Model 1: Predict from trigram, if not found, then quadgram, then bigram, then unigram libraries.
- Model 2: Predict from trigram, if not found, then bigram then unigram libraries

##Prediction Models
Validation turned out to be very tricky with such a large amount of data. Model 2 was considered due to difficulty in validation with Model 1. Prediction models were validated with 0.1%, 0.3%, 1% of the raw data but validation failed due to memory leak when attempted with 10% of raw data.  Model 2 has better prediction accuracy than Model 1 when validated with 0.3% of Raw Data:

## Final Prediction Model
Model 2 was picked and was validated with up to 1% of raw data.
As the amount of data increased for training, prediction accurary improved:
10% of the raw data set was used for final prediction model training. Due to failure in validation with such large amount of data, exact accuracy remains unknown. The accuracy is expected to be better than 0.45 (1% of raw data). 


