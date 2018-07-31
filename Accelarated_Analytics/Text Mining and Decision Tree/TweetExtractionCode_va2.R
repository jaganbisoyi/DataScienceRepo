#Calling all the libraries
library(twitteR)
library(wordcloud)
library(Rstem)
library(sentiment)
library(tm)
library(qdap)
library(syuzhet)
library(ggplot2)

### Twitter Application This needs to be changed for your respective accounts

consumerKey="Lkua6CVfeSY4KHbgV2XwSzVno" #Replace with your consumerKey
consumerSecret="1P22rij98PBLgesP0GlY1f0fpglicZoFYxTWdAf4Y9OBLmXhKn" #Replace with your consumerSecret
accesstoken="2516050418-H8Z1WTbOiiYu3SrL5cjIPmyJOe6lg9gVehu1951" #Replace with your accesstoken
accesssecret="j21rDsQhJGgti7qVL3jerThMRjuS6ys67qnFKzkKUCAHS" #Replace with your accesssecret

#Setup Authentication
setup_twitter_oauth(consumerKey,consumerSecret,access_token = accesstoken, access_secret = accesssecret)

#Extract Tweets from Twitter
FlipkartTweets <- searchTwitteR("#Flipkart", n =500) 

#Convert Tweets in to Vector

FKTW <- twListToDF(FlipkartTweets)
tweets <- FKTW$text
tweets1 <- VectorSource(FKTW$text)
corp <- VCorpus(tweets1)

# Cleaning Data
#Sample Text
text <- "<b>She</b> woke up at       6 A.M. It\'s so early!  She was only 10% awake and began drinking coffee in front of her computer."

#Lower Case
tolower(text)

#Remove Punctuations
removePunctuation(text)

#Remove Numbers
removeNumbers(text)

#Remove White Spaces
stripWhitespace(text)

#Remove Stop Words
stopwords("en")

#Remove anything in brackets
bracketX(text)

#Replace Contractions
replace_contraction(text)

#Replace Symbols
replace_symbol(text)

#Stemming
complicate <- c("complicated", "complication", "complicatedly")
stem_doc <- stemDocument(complicate)

#Cleaning Tweets
tweets = gsub("(http|https)://.+", "", tweets)
tweets <- gsub("#"," ", tweets)
corp <- tm_map(corp,content_transformer(tolower))
corp <- tm_map(corp,removePunctuation)
corp <- tm_map(corp,removeNumbers)
corp <- tm_map(corp,stripWhitespace)
corp <- tm_map(corp,removeWords, stopwords("english"))
corp <- tm_map(corp, content_transformer(bracketX))
corp <- tm_map(corp, content_transformer(replace_number))
corp <- tm_map(corp, content_transformer(replace_contraction))
corp <- tm_map(corp, content_transformer(replace_symbol))
corp <- tm_map(corp,stemDocument)

#Converting to DTM
twtdm <- DocumentTermMatrix(corp)

#Removing Sparse Terms
twsparse <- removeSparseTerms(twtdm, .99)

#Word Frequency
tf <- sort(colSums(as.matrix(twsparse)), decreasing = TRUE)
words <- names(tf)

#Word Cloud
wordcloud(words, tf,colors = brewer.pal(8,"Set2"), scale = c(5,1))

####Sentiment Analysis

get_nrc_sentiment("I bought an iPhone a few days ago. It is such a nice phone, although a little large. The touch screen is cool.The voice quality is clear too. I simply love it!")

mysentiment <- get_nrc_sentiment(tweets)
SentimentScores <- data.frame(colSums(mysentiment[,]))
names(SentimentScores) <- "Score"
SentimentScores <- cbind("sentiment" = rownames(SentimentScores), SentimentScores)
rownames(SentimentScores) <- NULL

ggplot(data = SentimentScores, aes(x = sentiment, y = Score)) +
  geom_bar(aes(fill = sentiment), stat = "identity") +
  xlab("Sentiment") + ylab("Score") + ggtitle("Total Sentiment Score Based on Tweets")