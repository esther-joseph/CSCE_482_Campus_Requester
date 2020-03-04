import pandas as pd 
import pyodbc 

#extracting data from sql server
#conn = pyodbc.connect('Driver={SQL Server};'
#                      'Server=pidginserver;'
#                      'Database=pidgindb;'
#                      'Trusted_Connection=yes;')

#conn = pyodbc.connect(driver='{SQL Server}', host='pidginserver', database='pidgindb',
#                      user='notpaul', password='delivery482@')

#cursor = conn.cursor()
#cursor.execute('SELECT * FROM dbo.Posts')

#alternatively, re-install keras in environment python 3.7(64-bit)

server = 'pidginserver.database.windows.net'
database = 'pidgin_2' #database for prices from orders
username = 'notpaul'
password = 'delivery482@'
driver= '{ODBC Driver 17 for SQL Server}'
cnxn = pyodbc.connect('DRIVER='+driver+';SERVER='+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()
cursor.execute("SELECT * FROM dbo.Posts")
row = cursor.fetchone()

cursor_list = []

while row:
   # print (str(row[0]) + " " + str(row[1]))
    row = cursor.fetchone()
    cursor_list.append(row)

#for row in cursor:
   # print(row)
    #cursor_list.append(row)


#print(cursor_list)

df_posts = pd.DataFrame(data = cursor_list, columns = ['info'])
print(df_posts)

#it works!
#now let's do it with a database of our own 
#look into inheritance for python from files


#create a sample SQL database, just for testing (under test.sql)

#allocate the data into pandas dataframe

#manipulate the dataframe into data_X and data_Y to create test data


#For price prediction, create a regression model of the price data

#Create predictions from the price data model gathered

#create histograms for data visualization of frequency of certain prices

