# Oracle Database Connection Template

# Production Date: 02/08/2016
# Last Edit: 06/27/2018
# Description and Note: This is a template program to access to Oracle database through R.

##############################################

##### Preparation - Install and enable package(s): 'RODBC'

##### Step 1 - Close previous connection objects

odbcCloseAll()

##### Step 2 - Configure a DSN for the target database

# First check if the DSN already exist in the computer. You can either check it in ODBC data
# source administration, or use the syntax below

# This function will list all the DSNs configured in your computer.
odbcDataSources()

# If the DSN already exists, skip to the next step; if not, you need to set up in the ODBC
# data source administration before you continue (see instructions at the end of the script)

##### Step 3 - Create a connection object

db_con = odbcConnect(dsn='xxxxxx',          # DSN name 
                     uid='yyyyyy',          # RAIFID
                     pwd='zzzzzz',          # Password 
                     # To hide the password, you can create an intermediate variable in
                     # a separate script and pass the value to 'pwd' here. Same as SAS.
                     believeNRows=FALSE, 
                     readOnlyOptimize=TRUE)
                     # Please noted schema name is not included here. It should be
                     # specified when you quote the table.

##### Step 4 - Extract data from Oracle Database with SQL query

# You can i) write your SQL query here, e.p.,
sql = 
  " SELECT 
      * 
    FROM SCHEMA.Table 
    WHERE ROWNUM <= 10;"  
# This is different from SAS. You have to quote the table with SchemaName.FullTableName.
# Also you have to code with Oracle SQL language, which is a little differenct from 
# standard SQL.

# or ii) read SQL query from external file
sql = readLines('data/sql/my_sql_script.sql')

# Collapses a multi-line (multi-string) SQL query into a single line (single string) that we 
# can use in the next step. This is not necessary for i).
sql = paste(sql, collapse=' ')  

# Extract data and create a local table to store it
mydf = as.data.frame(sqlQuery(db_con,sql))

##### Step 5 - Insert your mind-blowing analysis!

##############################################

##### HOW TO CONFIGURE AN ORACLE DSN IN ODBC DATA SOURCE ADMINISTRATION

# Click Star menu and search 'Microsoft ODBC Administrator' (64-bit).
# Open 'Drivers' tab and check if you have installed 'Oracle in OraClient 11g_home1'.
# If not, see if you can find it in Self Service Software Portal by searching 'Oracle Client 
# 11g R2 11.2.0 x64 v1';
# (Note: this driver is only compatible to 64-bit system, so we have to use the 64-bit ODBC
# Adminstrator here.)
# If yes, continue.
# Open 'User DSN' tab and click 'Add'.
# Choose 'Oracle in OraClient 11g_home1' and click 'Finish'.
# Input data source name, description, TNS service name and user ID, and leave everything else
# unchaged.
# Click 'Test Connection' and input the password and then click 'OK'.
# If you see a window of 'Connection Successful', then the configuration is completed 
# successfully.
