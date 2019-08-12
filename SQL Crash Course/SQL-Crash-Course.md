SQL Crash Course
================
Victor Farfan
8/7/2019

``` r
require(RMySQL)
```

    ## Loading required package: RMySQL

    ## Loading required package: DBI

``` r
connection_name <- "datawrangling.co4pgsadnasr.us-east-2.rds.amazonaws.com"
db_name <- "dataWrangling"
user <- "dstrack"
password <- "datawrangling2019"
drv = dbDriver("MySQL")
mydb = dbConnect(drv,host=connection_name,dbname=db_name,user=user,pass=password)
```

\#Ejercicio
1

``` r
hero <- dbGetQuery(mydb, "SELECT name, Publisher FROM heroes_information")
head(hero)
```

    ##            name         Publisher
    ## 1        A-Bomb     Marvel Comics
    ## 2    Abe Sapien Dark Horse Comics
    ## 3      Abin Sur         DC Comics
    ## 4   Abomination     Marvel Comics
    ## 5       Abraxas     Marvel Comics
    ## 6 Absorbing Man     Marvel Comics

\#Ejercicio
2

``` r
hero <- dbGetQuery(mydb, "SELECT DISTINCT(Publisher) FROM heroes_information")
head(hero)
```

    ##           Publisher
    ## 1     Marvel Comics
    ## 2 Dark Horse Comics
    ## 3         DC Comics
    ## 4      NBC - Heroes
    ## 5         Wildstorm
    ## 6      Image Comics

\#Ejercicio
3

``` r
hero <- dbGetQuery(mydb, "SELECT COUNT(DISTINCT(Publisher)) FROM heroes_information")
head(hero)
```

    ##   COUNT(DISTINCT(Publisher))
    ## 1                         24

\#Ejercicio
4

``` r
hero <- dbGetQuery(mydb, "SELECT * FROM heroes_information where height>200")
head(hero)
```

    ##   id        name Gender Eye color              Race Hair color Height
    ## 1  0      A-Bomb   Male    yellow             Human    No Hair    203
    ## 2  3 Abomination   Male     green Human / Radiation    No Hair    203
    ## 3 17       Alien   Male      NULL   Xenomorph XX121    No Hair    244
    ## 4 19       Amazo   Male       red           Android       NULL    257
    ## 5 29     Ant-Man   Male      blue             Human      Blond    211
    ## 6 33  Anti-Venom   Male      blue          Symbiote      Blond    229
    ##           Publisher Skin color Alignment Weight
    ## 1     Marvel Comics       NULL      good    441
    ## 2     Marvel Comics       NULL       bad    441
    ## 3 Dark Horse Comics      black       bad    169
    ## 4         DC Comics       NULL       bad    173
    ## 5     Marvel Comics       NULL      good    122
    ## 6     Marvel Comics       NULL      NULL    358

\#Ejercicio
5

``` r
hero <- dbGetQuery(mydb, "SELECT * FROM heroes_information where Race='Human'")
head(hero)
```

    ##   id              name Gender Eye color  Race Hair color Height
    ## 1  0            A-Bomb   Male    yellow Human    No Hair    203
    ## 2  5     Absorbing Man   Male      blue Human    No Hair    193
    ## 3  7      Adam Strange   Male      blue Human      Blond    185
    ## 4  9         Agent Bob   Male     brown Human      Brown    178
    ## 5 14       Alex Mercer   Male      NULL Human       NULL    -99
    ## 6 16 Alfred Pennyworth   Male      blue Human      Black    178
    ##       Publisher Skin color Alignment Weight
    ## 1 Marvel Comics       NULL      good    441
    ## 2 Marvel Comics       NULL       bad    122
    ## 3     DC Comics       NULL      good     88
    ## 4 Marvel Comics       NULL      good     81
    ## 5     Wildstorm       NULL       bad    -99
    ## 6     DC Comics       NULL      good     72

\#Ejercicio
6

``` r
hero <- dbGetQuery(mydb, "SELECT * FROM heroes_information where Race='Human' and Height>200;")
head(hero)
```

    ##    id        name Gender Eye color  Race Hair color Height     Publisher
    ## 1   0      A-Bomb   Male    yellow Human    No Hair    203 Marvel Comics
    ## 2  29     Ant-Man   Male      blue Human      Blond    211 Marvel Comics
    ## 3  59        Bane   Male      NULL Human       NULL    203     DC Comics
    ## 4 119    Bloodaxe Female      blue Human      Brown    218 Marvel Comics
    ## 5 221 Doctor Doom   Male     brown Human      Brown    201 Marvel Comics
    ## 6 373  Juggernaut   Male      blue Human        Red    287 Marvel Comics
    ##   Skin color Alignment Weight
    ## 1       NULL      good    441
    ## 2       NULL      good    122
    ## 3       NULL       bad    180
    ## 4       NULL       bad    495
    ## 5       NULL       bad    187
    ## 6       NULL   neutral    855

\#Ejercicio
7

``` r
hero <- dbGetQuery(mydb, "SELECT count(*) FROM heroes_information where weight>100 and weight<200;")
head(hero)
```

    ##   count(*)
    ## 1       98

\#Ejercicio
8

``` r
hero <- dbGetQuery(mydb, "SELECT count(*) FROM heroes_information WHERE (`Eye color`='blue') or (`Eye color`='red');")
head(hero)
```

    ##   count(*)
    ## 1      271

\#Ejercicio
9

``` r
hero <- dbGetQuery(mydb, "SELECT count(*) FROM heroes_information WHERE weight BETWEEN 100 and 200;")
head(hero)
```

    ##   count(*)
    ## 1       98

\#Ejercicio
10

``` r
hero <- dbGetQuery(mydb, "SELECT name, weight, height FROM heroes_information where weight>200 and height>100 order by height desc;")
head(hero)
```

    ##             name weight height
    ## 1          MODOK    338    366
    ## 2      Wolfsbane    473    366
    ## 3      Onslaught    405    305
    ## 4      Sasquatch    900    305
    ## 5     Juggernaut    855    287
    ## 6 Solomon Grundy    437    279

``` r
hero <- dbGetQuery(mydb, "SELECT name, Race FROM heroes_information order by name, race;")
head(hero)
```

    ##            name              Race
    ## 1        A-Bomb             Human
    ## 2    Abe Sapien     Icthyo Sapien
    ## 3      Abin Sur           Ungaran
    ## 4   Abomination Human / Radiation
    ## 5       Abraxas     Cosmic Entity
    ## 6 Absorbing Man             Human

\#Ejercicio
11

``` r
hero <- dbGetQuery(mydb, "SELECT Publisher, Gender, count(*) FROM heroes_information WHERE Gender='Female' Group by Publisher order by 3 desc;")
head(hero)
```

    ##           Publisher Gender count(*)
    ## 1     Marvel Comics Female      111
    ## 2         DC Comics Female       61
    ## 3      NBC - Heroes Female        7
    ## 4 Dark Horse Comics Female        5
    ## 5      Image Comics Female        2
    ## 6              <NA> Female        2

\#Ejercicio
12

``` r
hero <- dbGetQuery(mydb, "SELECT Publisher, Alignment, Race, count(*) FROM heroes_information where Alignment='Good' Group by Publisher having count(Publisher) > 30;")
head(hero)
```

    ##       Publisher Alignment    Race count(*)
    ## 1     DC Comics      good Ungaran      142
    ## 2 Marvel Comics      good   Human      259
