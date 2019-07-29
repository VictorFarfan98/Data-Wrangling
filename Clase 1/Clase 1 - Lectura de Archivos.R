library(readr)
library(tidyverse)
library(tidytext)


text_file <- "D:/Githubs/Data Wrangling/Clase 1/data/quijote.txt"
readLines(text_file, encoding = "UTF-8")

#Usando readr
quijote_lines <- read_lines(text_file)
quijote_lines

#Performance de funciones
system.time(readLines(text_file, encoding = "UTF-8"))
system.time(read_lines(text_file))


#Obtener partes de un string

#ufuncs o funciones universales

substr("0101020000020101",1,6)


#Tokenizar 
quijote_frame <- data_frame(txt=quijote_lines)
head(quijote_frame)
quijote_words <- unnest_tokens(quijote_frame, input=txt, output=words, token="words")
head(quijote_words)


#ya podemos contar
quijote_count <- count(quijote_words, words, sort = TRUE)
class(quijote_count)

#limpiar stopwords
library(quanteda)

spanish_stopwords <- data_frame(words=quanteda::stopwords(language = "es"))
View(spanish_stopwords)

quijote_words_clean <- anti_join(quijote_words,spanish_stopwords)

quijote_clean_count <- count(quijote_words_clean, words, sort = TRUE)
quijote_clean_count
