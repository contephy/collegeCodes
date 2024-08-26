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
    Dense(1, activation='linear')  
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
