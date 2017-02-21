#This script is designed to provide exmaples of how to import data from
# various sources. 

###---------------------------Begin Template--------------------------------###




##Comma Separated Value File (data has headers)
#save source filepath & name to variable
source01 <- "C:\\Users\\james\\Documents\\R\\wrk\\sample.csv"

#Read in file into raw dataset
rawData <- read.csv(source01, sep=",", header = TRUE, row.names = "id")
  #'sep' can be a number of options including \t for tab delimited




##Delimited Text File (data has no headers)
#save source filepath & name to variable
file <- "C:\\Users\\james\\Documents\\R\\wrk\\sample.txt"

#save source filepath & name to variable
rawData <- read.csv(file, sep=",");  
  #'sep' can be a number of options including \t for tab delimited

#add headers to the raw data set
names(rawData) <- c("VAR1","VAR2","RESPONSE1")




##Tab delimited Text File (using read.table from a file on the internet)
dat.tab <- read.table("http://www.ats.ucla.edu/stat/data/hsb2.txt",
                      header=TRUE, sep = "\t")



##Import SPSS files from already exported SPSS data set
library(foreign)

rawData <- read.spss("http://www.ats.ucla.edu/stat/data/hsb2.sav",
                      to.data.frame = TRUE)




##Import Stata files from already exported Stata data set
library(foreign)

rawData <- read.dta("http://www.ats.ucla.edu/stat/data/hsb2.dta")




##Import SAS files from SAS after exporting them into transport file

# save SAS dataset in trasport format
###libname out xport 'c:/mydata.xpt';
###data out.mydata;
###set sasuser.mydata;
###run;

# in R 
library(Hmisc)
mydata <- sasxport.get("c:/mydata.xpt")
# character variables are converted to R factors - REFORMAT!!!




##Import Excel worksheet within Excel workbook
library(xlsx)

rawData <- read.xlsx("c:/myexcel.xlsx", sheetName = "mysheet")




##Import data from relational databases (make sure you have ODBC connection setup)
#this example will work on any standard SQL database
library(RODBC)

channel <- odbcConnect("MY_DATABASE", uid="username", pwd="password")

raw <- sqlQuery(channel, "SELECT * FROM Table1")

close(channel)




##Import data from non-relational databases (make sure you have your connectsion
#properly set up)
library(rmongodb)
MyMongodb <- "test"
ns <- "articles"
mongo <- mongo.create(db=MyMmongodb)

list.d <- mongo.bson.from.list(list(
  "_id"="wes",
  name=list(first="Wesley", last=""),
  sex="M",
  age=40,
  value=c("7", "5","8","2")
))
mongo.insert(mongo, "test.MyPeople", list.d)
list.d2 <- mongo.bson.from.list(list(
  "_id"="Article1",
  when=mongo.timestamp.create(strptime("2012-10-01 01:30:00",
                                       "%Y-%m-%d %H:%M:%s"), increment=1),
  author="wes",
  title="Importing Data Into R from Different Sources",
  text="Provides R code on how to import data into R from different sources.",
  tags=c("R", "MongoDB", "Cassandra","MySQL","Excel","SPSS"),
  comments=list(
    list(
      who="wes",
      when=mongo.timestamp.create(strptime("2012-10-01 01:35:00",
                                           "%Y-%m-%d %H:%M:%s"), increment=1),
      comment="I'm open to comments or suggestions on other data sources to include."
    )
  )
)
)
list.d2
mongo.insert(mongo, "test.MyArticles", list.d2)

res <- mongo.find(mongo, "test.MyArticles", query=list(author="wes"), 
                  fields=list(title=1L))
out <- NULL
while (mongo.cursor.next(res)){
  out <- c(out, list(mongo.bson.to.list(mongo.cursor.value(res))))
  
}

out




##Read in copied and pasted text located in the script
raw_txt <- "
STATE READY TOTAL
AL 36 36
AK 5 8
AZ 15 16
AR 21 27
CA 43 43
CT 56 68
DE 22 22
DC 7 7
FL 130 132
GA 53 54
HI 11 16
ID 11 11
IL 24 24
IN 65 77
IA 125 130
KS 22 26
KY 34 34
LA 27 34
ME 94 96
MD 25 26
MA 82 92
Mi 119 126
MN 69 80
MS 43 43
MO 74 82
MT 34 40
NE 9 13
NV 64 64
NM 120 137
NY 60 62
NJ 29 33
NH 44 45
ND 116 135
NC 29 33
OH 114 130
OK 19 22
PA 101 131
RI 32 32
Sc 35 45
SD 25 25
TN 30 34
TX 14 25
UT 11 11
VT 33 49
VA 108 124
WV 27 36
WI 122 125
WY 12 14
"
raw_data <- textConnection(raw_txt)
raw <- read.table(raw_data, header=TRUE, comment.char="#", sep="")
close.connection(raw_data)

raw

###Or the following line can be used

raw <- read.table(header=TRUE, text=raw_txt)




##Readin structured to laocal data from machine This example uses the XML 
#library and pulls down the population by country in the world.  Once the 
#data is brought into R it may need to be cleaned up a bit removing 
#unnecessary columns and other stray characters.  The examples here use 
#remote data from other Web sites
library(XML)

url <- "http://en.wikipedia.org/wiki/List_of_countries_by_population"
population = readHTMLTable(url, which=3)
population

#Alternative code to grab XML from site
url <- "http://open.mapquestapi.com/geocoding/v1/address?location=1600%20Pennsylvania%20Ave,%20Washington,%20DC&outFormat=xml"
mygeo <- xmlToDataFrame(url)
mygeo$result

#Another alternative approach to grab data via JSON method
library(rjson)
url <- "http://open.mapquestapi.com/geocoding/v1/address?location=1600%20Pennsylvania%20Ave,%20Washington,%20DC&outFormat=json"

raw_json <- scan(url, "", sep="\n")

mygeo <- fromJSON(raw_json)




###----------------------------End Template---------------------------------###