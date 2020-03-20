from __future__ import absolute_import, division, print_function, unicode_literals
import tensorflow as tf
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

df = pd.DataFrame(data = cursor_list, columns = ['Info', 'Price'])
#print(df)

df.head()
df.dtypes

df['Info'] = pd.Categorical(df['Info'])
df['Info'] = df.Info.cat.codes
df.head()

price = df.pop('Price')
dataset = tf.data.Dataset.from_tensor_slices((df.values, price.values))

for feat, pric in dataset.take(5):
  print ('Features: {}, Target: {}'.format(feat, pric))

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
model.fit(train_dataset, epochs=15)

model.predict()
