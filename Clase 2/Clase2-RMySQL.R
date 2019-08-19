require(RMySQL)
connection_name <- "datawrangling.co4pgsadnasr.us-east-2.rds.amazonaws.com"
db_name <- "dataWrangling"
user <- "dstrack"
password <- "datawrangling2019"
drv = dbDriver("MySQL")
mydb = dbConnect(drv,host=connection_name,dbname=db_name,user=user,pass=password)

summary(mydb)

dbListTables(mydb)

dbListFields(mydb, "heroes_information")


##como son esas columnas
dbColumnInfo(mydb, "heroes_information")


hero <- dbReadTable(mydb, "heroes_information")
head(hero)


#dbGetQuery
hero <- dbGetQuery(mydb, "SELECT * FROM heroes_information;")
head(hero)


##dbSendQuery y Fetch
Query <- dbSendQuery(mydb, "SELECT * FROM heroes_information;")
hero <- dbFetch(Query, n=10)
hero

dbGetInfo(Query)


##Cuantas filas me va a retornar
dbGetRowCount(Query)


##dbWriteTable()
x <- 1:10
y <- letters[1:10]
test <- data.frame(x,y, stringsAsFactors = FALSE)
query <- dbWriteTable(mydb, "testVictorFarfan20170473", test, rownames=FALSE)
dbClearResult(query)

x <- 1:10
y <- letters[11:20]
test2 <- data.frame(x,y, stringsAsFactors = FALSE)
query <- dbWriteTable(mydb, "testVictorFarfan20170473", test2, rownames=FALSE, overwrite=TRUE)
dbClearResult(query)



#append a la table
x <- sample(100, 10)
y <- letters[6:15]
test3 <- data.frame(x,y, stringsAsFactors = FALSE)
dbWriteTable(mydb, "testVictorFarfan20170473", test, test3, append=TRUE)

