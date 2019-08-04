Laboratorio 1
================
Victor Farfan
7/31/2019

``` r
library(readxl)
library(openxlsx)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(xlsx)
```

    ## 
    ## Attaching package: 'xlsx'

    ## The following objects are masked from 'package:openxlsx':
    ## 
    ##     createWorkbook, loadWorkbook, read.xlsx, saveWorkbook,
    ##     write.xlsx

``` r
addDate <- function(x){
  df <- read_excel(x)
  df <- df[,c("COD_VIAJE","CLIENTE","UBICACION","CANTIDAD","PILOTO","Q","CREDITO","UNIDAD")]
  df$FECHA <- substring(x, 1, 7)
  return(df)
}

listado <- list.files(pattern = "*.xlsx")
dfs <- lapply(listado, "addDate")
```

    ## New names:
    ## * `` -> ...10

    ## New names:
    ## * `` -> ...1

``` r
all <- do.call("rbind",dfs)
all
```

    ## # A tibble: 4,360 x 9
    ##    COD_VIAJE CLIENTE   UBICACION CANTIDAD PILOTO     Q CREDITO UNIDAD FECHA
    ##        <dbl> <chr>         <dbl>    <dbl> <chr>  <dbl>   <dbl> <chr>  <chr>
    ##  1  10000001 EL PINCH~     76002     1200 Ferna~ 300        30 Camio~ 01-2~
    ##  2  10000002 TAQUERIA~     76002     1433 Hecto~ 358.       90 Camio~ 01-2~
    ##  3  10000003 TIENDA L~     76002     1857 Pedro~ 464.       60 Camio~ 01-2~
    ##  4  10000004 TAQUERIA~     76002      339 Angel~  84.8      30 Panel  01-2~
    ##  5  10000005 CHICHARR~     76001     1644 Juan ~ 411        30 Camio~ 01-2~
    ##  6  10000006 UBIQUO L~     76001     1827 Luis ~ 457.       30 Camio~ 01-2~
    ##  7  10000007 CHICHARR~     76002     1947 Ismae~ 487.       90 Camio~ 01-2~
    ##  8  10000008 TAQUERIA~     76001     1716 Juan ~ 429        60 Camio~ 01-2~
    ##  9  10000009 EL GALLO~     76002     1601 Ismae~ 400.       30 Camio~ 01-2~
    ## 10  10000010 CHICHARR~     76002     1343 Ferna~ 336.       90 Camio~ 01-2~
    ## # ... with 4,350 more rows

``` r
write.xlsx(all, "compilado.xlsx")
```

``` r
library(modes)
moda=function(x) {
    q=table(x)
    q=sort(q,TRUE)
    return(q[1])
}


modas <- lapply(all, moda)
modas
```

    ## $COD_VIAJE
    ## 10000001 
    ##        2 
    ## 
    ## $CLIENTE
    ## TAQUERIA EL CHINITO 
    ##                 278 
    ## 
    ## $UBICACION
    ## 76002 
    ##  2190 
    ## 
    ## $CANTIDAD
    ## 1126 
    ##   12 
    ## 
    ## $PILOTO
    ## Fernando Mariano Berrio 
    ##                     534 
    ## 
    ## $Q
    ## 281.5 
    ##    12 
    ## 
    ## $CREDITO
    ##   30 
    ## 1542 
    ## 
    ## $UNIDAD
    ## Camion Grande 
    ##          2422 
    ## 
    ## $FECHA
    ## compila 
    ##    2180

``` r
library(readr)

dataset = read_delim(file = "INE_PARQUE_VEHICULAR_080219.txt", delim = "|", col_names = TRUE, na = "n/a")
```

    ## Warning: Missing column names filled in: 'X11' [11]

    ## Parsed with column specification:
    ## cols(
    ##   ANIO_ALZA = col_double(),
    ##   MES = col_character(),
    ##   NOMBRE_DEPARTAMENTO = col_character(),
    ##   NOMBRE_MUNICIPIO = col_character(),
    ##   MODELO_VEHICULO = col_character(),
    ##   LINEA_VEHICULO = col_character(),
    ##   TIPO_VEHICULO = col_character(),
    ##   USO_VEHICULO = col_character(),
    ##   MARCA_VEHICULO = col_character(),
    ##   CANTIDAD = col_double(),
    ##   X11 = col_character()
    ## )

    ## Warning: 2362740 parsing failures.
    ## row col   expected     actual                              file
    ##   1  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080219.txt'
    ##   2  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080219.txt'
    ##   3  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080219.txt'
    ##   4  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080219.txt'
    ##   5  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080219.txt'
    ## ... ... .......... .......... .................................
    ## See problems(...) for more details.

``` r
dataset
```

    ## # A tibble: 2,362,732 x 11
    ##    ANIO_ALZA MES   NOMBRE_DEPARTAM~ NOMBRE_MUNICIPIO MODELO_VEHICULO
    ##        <dbl> <chr> <chr>            <chr>            <chr>          
    ##  1      2007 05    HUEHUETENANGO    HUEHUETENANGO    2007           
    ##  2      2007 05    EL PROGRESO      EL JICARO        2007           
    ##  3      2007 05    SAN MARCOS       OCOS             2007           
    ##  4      2007 05    ESCUINTLA        "SAN JOS\xc9"    2006           
    ##  5      2007 05    JUTIAPA          MOYUTA           2007           
    ##  6      2007 05    GUATEMALA        FRAIJANES        1997           
    ##  7      2007 05    QUETZALTENANGO   QUETZALTENANGO   2007           
    ##  8      2007 05    SUCHITEPEQUEZ    CHICACAO         2007           
    ##  9      2007 05    ESCUINTLA        ESCUINTLA        2007           
    ## 10      2007 05    GUATEMALA        MIXCO            2007           
    ## # ... with 2,362,722 more rows, and 6 more variables:
    ## #   LINEA_VEHICULO <chr>, TIPO_VEHICULO <chr>, USO_VEHICULO <chr>,
    ## #   MARCA_VEHICULO <chr>, CANTIDAD <dbl>, X11 <chr>
