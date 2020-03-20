import pandas as pd 
import pyodbc 

server = 'pidginserver.database.windows.net'
database = 'pidgin_2' #database for prices from orders
username = 'notpaul'
password = 'delivery482@'
driver= '{ODBC Driver 17 for SQL Server}'
cnxn = pyodbc.connect('DRIVER='+driver+';SERVER='+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()
cursor.execute("SELECT * FROM dbo.OrderDetails$")
row = cursor.fetchone()

cursor_list = []
for row in cursor:
    row_to_list = [elem for elem in row]
    cursor_list.append(row_to_list)

df_orders = pd.DataFrame(data = cursor_list, columns = ['Item Details', 'Price'])
print(df_orders)

#code works, transfer the following into to keras_pp.py
