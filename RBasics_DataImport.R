#This script is designed to provide exmaples of how to import data from
# various sources. 



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
raw_data <- read.csv(file, sep=",");  
  #'sep' can be a number of options including \t for tab delimited

#add headers to the raw data set
names(raw_data) <- c("VAR1","VAR2","RESPONSE1")



##Tab delimited Text File (using read.table from a file on the internet)
dat.tab <- read.table("http://www.ats.ucla.edu/stat/data/hsb2.txt",
                      header=TRUE, sep = "\t")