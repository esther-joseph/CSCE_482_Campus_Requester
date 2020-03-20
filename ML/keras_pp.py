from __future__ import absolute_import, division, print_function, unicode_literals
import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3' 
import tensorflow as tf
import pandas as pd 
import numpy as np
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

df = pd.DataFrame(data = cursor_list, columns = ['Info', 'Price'])
#print(df)

df.head()
df.dtypes

df['Info'] = pd.Categorical(df['Info'])
df['Info'] = df.Info.cat.codes
df.head()

price = df.pop('Price')
dataset = tf.data.Dataset.from_tensor_slices((df.values, price.values))

#for feat, pric in dataset.take(5):
#  print ('Features: {}, Target: {}'.format(feat, pric))

tf.constant(df['Info'])
train_dataset = dataset.shuffle(len(df)).batch(1)

def get_compiled_model():
  model = tf.keras.Sequential([
    tf.keras.layers.Dense(10, activation='relu'),
    tf.keras.layers.Dense(10, activation='relu'),
    tf.keras.layers.Dense(1)
  ])

  model.compile(optimizer='adam',
                loss=tf.keras.losses.BinaryCrossentropy(from_logits=True),
                metrics=['accuracy'])
  return model

model = get_compiled_model()
model.fit(train_dataset, verbose = 0, epochs=15)

def predict():
    predictions = model.predict(train_dataset, batch_size=None, verbose=0, steps=None, callbacks=None, max_queue_size=10, workers=1, use_multiprocessing=False)
    mean_prediction = np.sum(predictions)
    print(mean_prediction)

pred = predict()
