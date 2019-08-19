library(tidyverse)
library(readr)

players_score <- read_csv("Clase 3/Players_Score.csv")
head(players_score)

players_score$cambio<-str_extract_all(players_score$Apps, "\\([^)]*\\)","")
players_score$cambio<-str_extract_all(players_score$cambio,"[0-9]+")
players_score$Apps<-str_replace_all(players_score$Apps, "\\([^)]*\\)","")


#volver todas las variables numericas a formato numerico
numbers <- c("age","Apps", "cambio", "Goals", "Assists", "Yel", "Red", "SpG", "PS", "AerialsWon", "Rating")
players_score[numbers] <- lapply(players_score[numbers], as.numeric)
head(players_score) %>% View()

players_score[numbers] <- players_score[numbers] %>%
  replace_na(list(age=0, Goals=0, Assists=0, Yel=0, Red=0, SpG=0, PS=0, AerialsWon=0, Rating=0))



#filter 
filter(players_score, club=="Real Madrid", age<30)


filter(players_score, club %in% c("Real Madrid", "Barceola"), age<30)



##Primer filtro pero con pipe
players_score %>%
  filter(club=="Real Madrid")


#Seleccionemos unicamente las columnas de club y edad y filtremos por club
filter(select(players_score, club, age), club=="Real Madrid")

#Seleccionemos unicamente las columnas de club y edad y filtremos por club
players_score %>%
  select(club, age) %>%
  filter(club=="Real Madrid")


players_score %>%
  mutate(Goal_Rate = Mins/Goals) %>%
  arrange(desc(Goal_Rate))
