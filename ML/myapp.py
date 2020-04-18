import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3' 
import numpy
import matplotlib.pyplot as plt
import math
from keras.models import Sequential
from keras.layers import Dense
import pandas as pd 
import pyodbc 
from flask import Flask, request, jsonify

#set up a way for python to extract SQL database
server = 'pidginserver.database.windows.net'
database = 'pidgin_2' #database for prices from orders
username = 'notpaul'
password = 'delivery482@'
driver= '{ODBC Driver 17 for SQL Server}'
cnxn = pyodbc.connect('DRIVER='+driver+';SERVER='+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()
cursor.execute("SELECT * FROM dbo.current_order_1$")
row = cursor.fetchone()

#extract raw data to python list
cursor_list = []
for row in cursor:
    row_to_list = [elem for elem in row]
    cursor_list.append(row_to_list)

#organize list to pandas dataframe
df_orders = pd.DataFrame(data = cursor_list, columns = ['Info', '1', '2', '3', '4', '5'])
#print(df_orders)

#expand price history of each item matching in a column
def extend_sql_col_to_pd():
	n_cols = len(df_orders.columns)
	new_cols_list = []

	#use SQL query to extract prices with matching item names from other tables
	server = 'pidginserver.database.windows.net'
	database = 'pidgin_2' #database for prices from orders
	username = 'notpaul'
	password = 'delivery482@'
	driver= '{ODBC Driver 17 for SQL Server}'
	cnxn = pyodbc.connect('DRIVER='+driver+';SERVER='+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password)
	cursor = cnxn.cursor()
	#so table1.someColumn is equal to order1.price, and this continues for order2.price and etc
	cursor.execute("SELECT * FROM order1$ LEFT JOIN current_order_1$ ON current_order_1$.F1 = order1$.F1")
	#create sample excel tables to make more sql tables to test this out, how to format string such that variables verify such tables?
	row = cursor.fetchone()

	#extract raw data to python list
	for row in cursor:
		row_to_list = [elem for elem in row]
		new_cols_list.append(row_to_list)

		#what if it creates more than one col since you're pulling from multiple tables?
		#create a pd and append it to the current one
		
	#organize list to pandas dataframe
	df_orders_appended = pd.DataFrame(data = new_cols_list)
	df_orders.drop(columns=['Info'])
	#print(df_orders_appended)

		#how to make sure that the price pulled from item aligns correctly on df_orders?

	
	return df_orders_appended

col = extend_sql_col_to_pd()
df_orders = col

len_col = len(df_orders. columns)
len_col_list = []
for l in range(len_col):
	len_col_list.append(str(l))

#print(len_col_list)
df_orders.columns = len_col_list

# convert an array of values into a dataset matrix
def create_dataset(dataset, look_back):
	dataX, dataY = [], []
	print(dataset)
	for i in range(len(dataset)-look_back-1):
		a = dataset[i:(i+look_back), 0]
		print(a)
		dataX.append(a)
		dataY.append(dataset[i + look_back, 0])
	return numpy.array(dataX), numpy.array(dataY)

# load the dataset
dataframe = df_orders.drop(['0', '6'], axis=1)
#print(dataframe)
_dataset = dataframe.values
_dataset = _dataset.astype('float32')

print(_dataset)

# split into train and test sets
train_size = int(len(_dataset) * 0.67)
test_size = len(_dataset) - train_size
train, test = _dataset[0:train_size,:], _dataset[train_size:len(_dataset),:]

#print(train)
#print(train)
print(numpy.shape(train))
print(numpy.shape(train))

# reshape dataset
look_back = 3
trainX, trainY = create_dataset(train, look_back)
testX, testY = create_dataset(test, look_back)

print("===================================")
print(trainX)
print(trainY)
print(numpy.shape(trainX))
print(numpy.shape(trainY))
print(type(trainX))
print(type(trainY))

# create and fit Multilayer Perceptron model
model = Sequential()
model.add(Dense(12, input_dim=look_back, activation='relu'))
model.add(Dense(8, activation='relu'))
model.add(Dense(1))
model.compile(loss='mean_squared_error', optimizer='adam')
model.fit(trainX, trainY, epochs=400, batch_size=2, verbose=0)


# Estimate model performance
trainScore = model.evaluate(trainX, trainY, verbose=0)
#print('Predicted Score from Train: %.2f' % trainScore )

testScore = model.evaluate(testX, testY, verbose=0)
#print('Predicted Score from Test: %.2f' % testScore)

# generate predictions for training
trainPredict = model.predict(trainX)
trp = numpy.sum(trainPredict)
#print(trp)
testPredict = model.predict(testX)
tsp = numpy.sum(testPredict)
#print(tsp)

# shift train predictions for plotting
trainPredictPlot = numpy.empty_like(dataset)
trainPredictPlot[:, :] = numpy.nan
trainPredictPlot[look_back:len(trainPredict)+look_back, :] = trainPredict


# shift test predictions for plotting
testPredictPlot = numpy.empty_like(dataset)
testPredictPlot[:, :] = numpy.nan
testPredictPlot[len(trainPredict)+(look_back*2)+1:len(dataset)-1, :] = testPredict


# plot baseline and predictions
plt.plot(dataset)
plt.plot(trainPredictPlot)
plt.plot(testPredictPlot)
#plt.show()


last_column_total = numpy.sum(df_orders.iloc[:,-1])
#print(last_column_total)

def price_prediction():
	pp = (trainScore + trp + testScore) - tsp or 0
	while pp < last_column_total:
		pp = (trainScore + trp + testScore) - tsp or 0
		if pp >= last_column_total:
			break
	return print(str(round(int(pp),2)))

print("The Predicted Price of The Order Is:")
pred = price_prediction()
print(type(pred))

myapp = Flask(__name__)

@myapp.route('/api', methods = ['GET'])
def pp_func():
	pred = price_prediction()
	return str(pred)

if __name__ == '__main__':
	myapp.run()
