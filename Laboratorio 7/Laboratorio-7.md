Laboratorio 7
================
Victor Farfan
9/22/2019

``` r
library(tidyr)
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
library(stringr)
library(readxl)
library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following object is masked from 'package:base':
    ## 
    ##     date

``` r
library(readr)
data <- data.frame(read_csv("c1.csv"))
```

    ## Warning: Missing column names filled in: 'X23' [23]

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_character(),
    ##   ID = col_double(),
    ##   origen = col_double(),
    ##   Lat = col_double(),
    ##   Long = col_double(),
    ##   height = col_double(),
    ##   X23 = col_logical()
    ## )

    ## See spec(...) for full column specifications.

``` r
#df <- data.frame(data)
#data
#df
```

``` r
#Volver la data tidy
costo_total <- data %>%
  select(ID, Camion_5, Pickup, Moto)
grouped <- gather(costo_total, key="transporte", value="costo_total", Camion_5:Moto)
grouped <- filter(grouped, costo_total != 'Q-')
data$transporte <- grouped$transporte
data$costo_total <- grouped$costo_total 

costo_directo <- data %>%
  select(ID, directoCamion_5, directoPickup, directoMoto)
#costo_directo
grouped <- gather(costo_directo, key="transporte", value="costo_directo", directoCamion_5:directoMoto)
grouped <- filter(grouped, costo_directo != 'Q-')
data$costo_directo <- grouped$costo_directo

costo_fijo <- data %>%
  select(ID, fijoCamion_5, fijoPickup, fijoMoto)
grouped <- gather(costo_fijo, key="transporte", value="costo_fijo", fijoCamion_5:fijoMoto)
grouped <- filter(grouped, costo_fijo != 'Q-')
data$costo_fijo <- grouped$costo_fijo

tiempos <- data %>%
  select(ID, X5.30, X30.45, X45.75, X75.120, X120.)

tiempos$X5.30[tiempos$X5.30=="x"] <- 1
tiempos$X30.45[tiempos$X30.45=="x"] <- 1
tiempos$X45.75[tiempos$X45.75=="x"] <- 1
tiempos$X75.120[tiempos$X75.120=="x"] <- 1
tiempos$X120.[tiempos$X120.=="x"] <- 1

grouped <- gather(tiempos, key="rangos", value="tiempo", X5.30:X120.)
grouped <- filter(grouped, tiempo == '1')
data$tiempo <- grouped$rangos

a <- dmy(data$Fecha)
b <- as.Date(as.integer(data$Fecha), origin = "1900-01-01") - days(2)
```

    ## Warning in as.Date(as.integer(data$Fecha), origin = "1900-01-01"): NAs
    ## introduced by coercion

``` r
a[is.na(a)] <- b[!is.na(b)] # Combine both while keeping their ranks
data$Fecha <- a # Put it back in your dataframe


data$factura <- as.numeric(gsub("Q", "", data$factura))
data$costo_total <- as.numeric(gsub("Q", "", data$costo_total))
data$costo_directo <- as.numeric(gsub("Q", "", data$costo_directo))
data$costo_fijo <- as.numeric(gsub("Q", "", data$costo_fijo))

data <- data %>% 
  mutate(Ganancia = factura-costo_total)

#Eliminar columnas sin uso
data$Camion_5 <- NULL
data$Pickup <- NULL
data$Moto <- NULL
data$directoCamion_5 <- NULL
data$directoPickup <- NULL
data$directoMoto <- NULL
data$fijoCamion_5 <- NULL
data$fijoPickup <- NULL
data$fijoMoto <- NULL
data$X5.30 <- NULL
data$X30.45 <- NULL
data$X45.75 <- NULL
data$X75.120 <- NULL
data$X120. <- NULL
data$X23 <- NULL 
head(data)
```

    ##        Fecha     ID                    Cod origen      Lat      Long
    ## 1 2017-12-10 368224 VERIFICACION_MEDIDORES 150277 15.46333 -89.72565
    ## 2 2017-03-19 368224 REVISION_TRANSFORMADOR 150277 15.46333 -89.72565
    ## 3 2017-03-13 368224               REVISION 150277 15.46333 -89.72565
    ## 4 2017-04-14 368224               REVISION 150224 15.46333 -89.72565
    ## 5 2017-04-11 748633               REVISION 150277 14.72568 -90.89644
    ## 6 2017-04-29 599434 VERIFICACION_MEDIDORES 150277 15.93645 -89.04138
    ##   factura height transporte costo_total costo_directo costo_fijo tiempo
    ## 1  316.72      8   Camion_5      363.17        232.43     130.74  X5.30
    ## 2  267.24      8   Camion_5      356.75        221.19     135.57  X5.30
    ## 3  236.04      8   Camion_5      377.56        252.96     124.59  X5.30
    ## 4  289.77      8   Camion_5      115.97         68.42      47.55  X5.30
    ## 5  248.33      8   Camion_5      371.07        241.19     129.87  X5.30
    ## 6  299.42     12   Camion_5      353.24        233.14     120.10  X5.30
    ##   Ganancia
    ## 1   -46.45
    ## 2   -89.51
    ## 3  -141.52
    ## 4   173.80
    ## 5  -122.74
    ## 6   -53.82

## Cosas que asumo

  - La latitud y longitud son las del poste que se va a reparar

## Cosas que asumo: Tipos de Servicio

``` r
data %>% 
  select(Cod) %>%
  distinct
```

    ##                         Cod
    ## 1    VERIFICACION_MEDIDORES
    ## 2    REVISION_TRANSFORMADOR
    ## 3                  REVISION
    ## 4            CAMBIO_FUSIBLE
    ## 5                      OTRO
    ## 6         CAMBIO_CORRECTIVO
    ## 7  VERIFICACION_INDICADORES
    ## 8                    VISITA
    ## 9     VISITA_POR_CORRECCION
    ## 10           CAMBIO_PUENTES

## Cosas que asumo: Transportes

``` r
data %>% 
  select(transporte) %>%
  distinct
```

    ##   transporte
    ## 1   Camion_5
    ## 2     Pickup
    ## 3       Moto

## Cosas que asumo: Puntos de origen

``` r
data %>% 
  select(origen) %>%
  distinct
```

    ##   origen
    ## 1 150277
    ## 2 150224
    ## 3 150841
    ## 4 150278

## Estado de resultados breve del 2017.

``` r
ventas <- sum(data$factura)
costos <- sum(data$costo_total)
ganancia <- ventas - costos
#paste('Q',formatC(sum(data$factura), big.mark=',', small.mark = '.', format = 'f'))

sprintf("Ventas Netas: %.2f", ventas)
```

    ## [1] "Ventas Netas: 36688096.31"

``` r
sprintf("Costo Total: %.2f", costos)
```

    ## [1] "Costo Total: 28174019.31"

``` r
sprintf("Ganancia Neta: %.2f", ganancia)
```

    ## [1] "Ganancia Neta: 8514077.00"

## ¿Cómo quedó el tarifario en el 2017 por unidad?

``` r
#ventas <- data %>% 
#  select(ID, factura) %>%
#  group_by(ID) %>% 
#  summarise(Ventas = sum(factura))

tarifario <- aggregate(x = data$costo_total, by=list(data$transporte), mean)
colnames(tarifario)<-c('Transporte', 'Tarifa')
tarifario
```

    ##   Transporte    Tarifa
    ## 1   Camion_5 139.05220
    ## 2       Moto  68.77693
    ## 3     Pickup  97.69384

## Las tarifas actuales ¿son aceptables por el cliente? ¿Estamos en números rojos?

``` r
#data %>%
#  group_by(ID) %>%
#  count(ID)

mes <- data %>%
  group_by(mes = month(Fecha)) %>% 
  count(ID)
#mes

mes <- mes %>%
  group_by(mes) %>%
  summarise(total = sum(n))

barplot(mes$total, names.arg = mes$mes, las=2, main="Reparaciones mensuales")
```

![](Laboratorio-7_files/figure-gfm/unnamed-chunk-8-1.png)<!-- --> \*
Podemos ver que la cantidad de reparaciones hechas por mes se mantienen
constantes durante el año y no hay ningun tipo de estacionalidad, por lo
que puedo decir que los clientes aceptan nuestras tarifas.

  - Como pudimos ver en el Estado de Resultados no estamos en números
    rojos porque estamos generando una utilidad neta positiva.

## ¿Cuándo podríamos perderle a un mantenimiento y/o reparación?

``` r
data %>% 
  filter(Ganancia < 0) %>%
  group_by(Cod) %>%
  count(Cod, sort = TRUE)
```

    ## # A tibble: 10 x 2
    ## # Groups:   Cod [10]
    ##    Cod                          n
    ##    <chr>                    <int>
    ##  1 REVISION                 30932
    ##  2 VERIFICACION_MEDIDORES   15921
    ##  3 CAMBIO_CORRECTIVO        13928
    ##  4 VERIFICACION_INDICADORES 10826
    ##  5 CAMBIO_FUSIBLE            5331
    ##  6 VISITA_POR_CORRECCION     3507
    ##  7 REVISION_TRANSFORMADOR    3332
    ##  8 OTRO                       924
    ##  9 VISITA                     892
    ## 10 CAMBIO_PUENTES             347

  - Cuando un factor externo aumente nuestros costos fijos o variables
  - Cuando el trabajo no compensen los costos de ir al poste, como una
    REVISION por ejemplo

## ¿Debemos abrir más centros de distribución?

``` r
dist <- count(data, data$origen)
colnames(dist)<-c('origen', '# Servicios')
dist
```

    ## # A tibble: 4 x 2
    ##   origen `# Servicios`
    ##    <dbl>         <int>
    ## 1 150224        104823
    ## 2 150277        105535
    ## 3 150278         26948
    ## 4 150841         26419

## ¿Qué estrategias debo seguir?

  - Pensar en tener nuevos puntos de origen que aligeren la carga de los
    origenes 150224 y
150277

## “80-20” de factura (puede variar el porcentaje) y cuáles postes requieren de más mantenimiento.

``` r
postes <- data %>% 
  group_by(ID) %>% 
  summarise(Total = sum(factura))
  

postes <- postes[order(-postes$Total),]

postes <- postes %>% 
  mutate(Percent = Total/ventas)
barplot(postes$Total, names.arg = postes$ID, las=2, main="Paretto de postes")
```

![](Laboratorio-7_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

## “80-20” de factura (puede variar el porcentaje) y cuáles postes requieren de más mantenimiento.

``` r
options(scipen = 999)     
servicio <- data %>%
  group_by(Cod) %>%
  summarise(Total = sum(factura)/1000)

servicio <- servicio[order(-servicio$Total),]
barplot(servicio$Total, names.arg = servicio$Cod, las=2, main="Paretto de postes por servicio (miles)", cex.names = 0.6, ylim = c(0,15000))
```

![](Laboratorio-7_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

## Recorridos más efectivos.

``` r
ef <- data %>%
  mutate(Efectividad = Ganancia/costo_total)

ef <- ef %>% 
  filter(Efectividad > 0)

ef <- ef %>% 
  select(ID, Cod, tiempo, Efectividad)

ef <- ef[order(-ef$Efectividad),]
ef <- ef[0:10,]
barplot(ef$Efectividad, names.arg = ef$Cod, las=2, main="Efectividad de Reparaciones por servicio", cex.names = 0.7)
```

![](Laboratorio-7_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

## Recorridos más efectivos.

``` r
barplot(ef$Efectividad, names.arg = ef$tiempo, las=2, main="Efectividad de Reparaciones por duracion", cex.names = 0.7)
```

![](Laboratorio-7_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->
