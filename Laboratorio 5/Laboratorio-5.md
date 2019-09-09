Laboratorio 5
================
Victor Farfan
9/8/2019

## Parte 1

``` r
library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following object is masked from 'package:base':
    ## 
    ##     date

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:lubridate':
    ## 
    ##     intersect, setdiff, union

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
start = make_datetime(day=21, month=8, year=2017, hour=18, min=26, sec=40)
start
```

    ## [1] "2017-08-21 18:26:40 UTC"

``` r
synodicmonth = days(29) + hours(12) + minutes(44) + seconds(3)
synodicmonth
```

    ## [1] "29d 12H 44M 3S"

``` r
saros = 223 * synodicmonth
saros
```

    ## [1] "6467d 2676H 9812M 669S"

``` r
nextsolareclipse = start + saros
print("Next solar eclipse:")
```

    ## [1] "Next solar eclipse:"

``` r
nextsolareclipse
```

    ## [1] "2035-09-02 02:09:49 UTC"

## Parte 2

## ¿En qué meses existe una mayor cantidad de llamadas por código?

``` r
library(dplyr)
library(readxl)
library(lubridate)

data <- read_excel("data.xlsx")
#data

a <- dmy(data$`Fecha Creación`)
```

    ## Warning: 104237 failed to parse.

``` r
b <- as.Date(as.integer(data$`Fecha Creación`), origin = "1900-01-01") - days(2)
```

    ## Warning in as.Date(as.integer(data$`Fecha Creación`), origin =
    ## "1900-01-01"): NAs introduced by coercion

``` r
a[is.na(a)] <- b[!is.na(b)] # Combine both while keeping their ranks
data$`Fecha Creación` <- a # Put it back in your dataframe

a <- dmy(data$`Fecha Final`)
```

    ## Warning: 104237 failed to parse.

``` r
b <- as.Date(as.integer(data$`Fecha Final`), origin = "1900-01-01") - days(2)
```

    ## Warning in as.Date(as.integer(data$`Fecha Final`), origin = "1900-01-01"):
    ## NAs introduced by coercion

``` r
a[is.na(a)] <- b[!is.na(b)] # Combine both while keeping their ranks
data$`Fecha Final` <- a # Put it back in your dataframe

#head(data)
```

## ¿En qué meses existe una mayor cantidad de llamadas por código?

``` r
mes <- data %>%
  group_by(Cod, month(`Fecha Creación`)) %>%
  count()
mes
```

    ## # A tibble: 84 x 3
    ## # Groups:   Cod, month(`Fecha Creación`) [84]
    ##    Cod   `month(\`Fecha Creación\`)`     n
    ##    <chr>                       <dbl> <int>
    ##  1 0                               1  1361
    ##  2 0                               2  1236
    ##  3 0                               3  1419
    ##  4 0                               4  1362
    ##  5 0                               5  1404
    ##  6 0                               6  1330
    ##  7 0                               7  1463
    ##  8 0                               8  1442
    ##  9 0                               9  1380
    ## 10 0                              10  1397
    ## # ... with 74 more rows

``` r
#mes[which.max(mes$n),]
```

## ¿Qué día de la semana es el más ocupado

``` r
dia <- data %>%
  group_by(day(`Fecha Creación`)) %>%
  count()
dia[which.max(dia$n),]
```

    ## # A tibble: 1 x 2
    ## # Groups:   day(`Fecha Creación`) [1]
    ##   `day(\`Fecha Creación\`)`     n
    ##                       <int> <int>
    ## 1                        10  8883

## ¿Existe una temporalidad en la cantidad de llamadas?

## ¿Cuántos minutos dura la llamada promedio?

``` r
data <- data %>%
  mutate(duracion = difftime(`Hora Final`, `Hora Creación`))

mean(data$duracion)
```

    ## Time difference of 893.377 secs

## Realice una tabla de frecuencias con el tiempo de llamada.
