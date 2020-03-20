import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3' 
import numpy
import matplotlib.pyplot as plt
import math
from keras.models import Sequential
from keras.layers import Dense
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

df_orders = pd.DataFrame(data = cursor_list, columns = ['Info', '9_22_19', '12_23_19', '1_21_20', '2_17_20', '3_18_20'])
#print(df_orders)

# convert an array of values into a dataset matrix
def create_dataset(dataset, look_back=1):
	dataX, dataY = [], []
	for i in range(len(dataset)-look_back-1):
		a = dataset[i:(i+look_back), 0]
		dataX.append(a)
		dataY.append(dataset[i + look_back, 0])
	return numpy.array(dataX), numpy.array(dataY)

# load the dataset
dataframe = df_orders.drop(['Info'], axis=1)
dataset = dataframe.values
dataset = dataset.astype('float32')


# split into train and test sets
train_size = int(len(dataset) * 0.67)
test_size = len(dataset) - train_size
train, test = dataset[0:train_size,:], dataset[train_size:len(dataset),:]


# reshape dataset
look_back = 3
trainX, trainY = create_dataset(train, look_back)
testX, testY = create_dataset(test, look_back)


# create and fit Multilayer Perceptron model
model = Sequential()
model.add(Dense(12, input_dim=look_back, activation='relu'))
model.add(Dense(8, activation='relu'))
model.add(Dense(1))
model.compile(loss='mean_squared_error', optimizer='adam')
model.fit(trainX, trainY, epochs=400, batch_size=2, verbose=0)


# Estimate model performance
trainScore = model.evaluate(trainX, trainY, verbose=0)
print('Predicted Score from Train: %.2f' % trainScore )

testScore = model.evaluate(testX, testY, verbose=0)
print('Predicted Score from Test: %.2f' % testScore)

# generate predictions for training
trainPredict = model.predict(trainX)
trp = numpy.sum(trainPredict)
print(trp)
testPredict = model.predict(testX)
tsp = numpy.sum(testPredict)
print(tsp)

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
	pp = (trainScore + trp + testScore) - tsp
	while pp < last_column_total:
		pp = (trainScore + trp + testScore) - tsp
		if pp >= last_column_total:
			break
	print(pp)

pred = price_prediction()
