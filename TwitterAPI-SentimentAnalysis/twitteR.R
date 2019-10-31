
library(twitteR)
library(dplyr)
library(readr)
consumer_key <- "vczDkThewxnbS0F4YIIlstryD"
consumer_secret <- "Hd7RwY8JlXYSA79wvEnOLMBsuiaZKTiNu9ibJ7VSiDtvbKXTdc"
access_token <- "469820606-3EUJLJRAcozaGQTNTaF4RkPSR1akTQsZwwQ0zadV"
access_secret <- "2z37v3qeMGVYsqGQJoHc5ByEWe1edEGqqBFRCukddoTwc"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

tw <- twitteR::searchTwitter('#Halloween', n = 1e4, since = '2019-10-21', retryOnRateLimit = 1e3)

df <- twitteR::twListToDF(tw)
df %>% head() %>% View()


write_csv(df,"tweets.csv")