##Load "RODBC" library
library(RODBC)

##View the ODBC connections that are already set up in our environment
odbcDataSources()

##Create Connection
db_con <- odbcConnect(dsn = "YOUR_DSN", uid = "user", pwd = "xxxxxxxx")

##Look at listing of tables in Norkom PDOA Schema
table.DB2.list <- sqlTables(db_con, tableType = "TABLE", schema = "YOUR_SCHEMA")

##List the columns in a particular table
table.name <- "YOUR_SCHEMA.YOUR_TABLE"
col.list <- sqlColumns(db_con,table.name)

##You can write your SQL query here
sql = 
    " SELECT * 
        FROM YOUR_SCHEMA.YOUR_TABLE
        FETCH FIRST 100 ROWS ONLY;"

##Extract data and create a local table to store it
mydf = as.data.frame(sqlQuery(db_con,sql))

##Now insert your mind-blowing analysis!
