Intro
================
Victor Farfan
7/24/2019

\#Instalar Librerias

``` r
#install.packages("dplyr")
#install.packages("RMySQL")
#install.packages("lubridate")
#install.packages("openxlsx")
#install.packages("tidyverse")
#install.packages("stringr")
#install.packages("readr")
```

# Cargando Librerias

``` r
require(dplyr)
```

    ## Loading required package: dplyr

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

# Tipos de dato

``` r
string <- "This is a string"
string
```

    ## [1] "This is a string"

``` r
class(string)
```

    ## [1] "character"

``` r
nchar(string)
```

    ## [1] 16

``` r
length(string)
```

    ## [1] 1

``` r
number <- 234L
class(number)
```

    ## [1] "integer"

``` r
typeof(number)
```

    ## [1] "integer"

``` r
logical = FALSE
```

``` r
factor_1 <- c("mon","tue","wed","thu","fri","sat","sun","sat","sun","wed","thu","fri","sat","sun","wed","thu","wed","thu")
factor_1 <- factor(factor_1)
factor_1
```

    ##  [1] mon tue wed thu fri sat sun sat sun wed thu fri sat sun wed thu wed
    ## [18] thu
    ## Levels: fri mon sat sun thu tue wed

``` r
as.numeric
```

    ## function (x, ...)  .Primitive("as.double")

``` r
factor_2 <- c("mon","tue","wed","thu","fri","sat","sun","sat","sun","wed","thu","fri","sat","sun","wed","thu","wed","thu")
factor_2 <- ordered(factor_2, levels = c("mon","tue","wed","thu","fri","sat","sun"))
factor_2
```

    ##  [1] mon tue wed thu fri sat sun sat sun wed thu fri sat sun wed thu wed
    ## [18] thu
    ## Levels: mon < tue < wed < thu < fri < sat < sun

# Vectores

``` r
#sample(x)
```
