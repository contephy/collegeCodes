import numpy as np
import pandas as pd
from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import train_test_split
from tensorflow.keras.callbacks import EarlyStopping, TensorBoard
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
from time import time

# Load data
df = pd.read_csv('material__data.csv')

# Data preprocessing
features = df[["effective hole mass", "min of e.n. diff"]].values
target = df[["PBE bandgap"]].values

scaler_X = MinMaxScaler()
features_normalized = scaler_X.fit_transform(features)

scaler_Y = MinMaxScaler()
target_normalized = scaler_Y.fit_transform(target)

# Split data
X_train, X_test, Y_train, Y_test = train_test_split(
    features_normalized, target_normalized, test_size=0.3, random_state=42, shuffle=True
)

# Set up TensorBoard and EarlyStopping
tensorboard = TensorBoard(log_dir='logs/{}'.format(time()))
early_stopping = EarlyStopping(monitor='val_loss', patience=20, restore_best_weights=True)

# Define the model
model = Sequential([
    Dense(64, activation='relu', input_shape=(X_train.shape[1],)),
    Dropout(0.2),
    Dense(64, activation='relu'),
    Dropout(0.2),
    Dense(32, activation='relu'),
    Dense(1, activation='linear')  # Use 'linear' for regression
])

# Compile the model
model.compile(loss='mean_squared_error',
              optimizer='adam',
              metrics=['mean_squared_error'])

# Train the model
EPOCHS = 500
model.fit(X_train, Y_train, epochs=EPOCHS, validation_split=0.2, callbacks=[early_stopping, tensorboard])

# Model summary
model.summary()

# Evaluate the model
test_loss, test_mse = model.evaluate(X_test, Y_test)
print(f'Test loss: {test_loss}')
print(f'Test MSE: {test_mse}')

'''
----------------------------------------------------------------------------------------------------------------------------------------
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from time import time
from tensorflow.python.keras.callbacks import TensorBoard
from keras.models import Sequential
from keras.layers.core import Dense, Dropout


df = pd.read_csv('material__data.csv')

x_array1 = df[["effective hole mass"]].to_numpy()
x_array2 = df[["min of e.n. diff"]].to_numpy()

x_array1 = x_array1/np.max(np.absolute(x_array1))
x_array2 = x_array2/np.max(np.absolute(x_array2))
x_array_II = np.array(list(zip(x_array1, x_array2)))
y_array = df[["PBE bandgap"]].to_numpy()
y_array = y_array/np.max(np.absolute(y_array))


X_train, X_test, Y_train, Y_test = train_test_split(
    x_array_II, y_array, test_size=0.3, random_state=42, shuffle=True)


tensorboard = TensorBoard(log_dir='logs/{}'.format(time()))



model= Sequential([
    Dense(16, activation='sigmoid'),
    Dense(32, activation='sigmoid'),
    Dense(64, activation='sigmoid'),
    Dense(128, activation='sigmoid'),
    Dropout(0.2),
    Dense(512, activation='relu'),
    Dropout(0.5),
    Dense(128, activation='sigmoid'),
    Dropout(0.2),
    Dense(64, activation='sigmoid'),
    Dense(32, activation='sigmoid'),
    Dense(16, activation='sigmoid'),
    Dense(1, activation='sigmoid')
])

model.compile(loss='mean_absolute_percentage_error',
                 optimizer='Adam',
                 metrics=['mean_squared_error'])


EPOCHS = 500

model.fit(X_train, Y_train, epochs=EPOCHS, callbacks=[tensorboard])
model.summary()

test_loss, test_accu = model.evaluate(X_test, Y_test)
'''
