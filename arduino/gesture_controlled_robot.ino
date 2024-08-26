#include <Wire.h>
#include <MPU6050.h>

// Initialize the MPU6050 sensor
MPU6050 mpu;

// Define pins for the motor driver
const int motorA1 = 2;
const int motorA2 = 3;
const int motorB1 = 4;
const int motorB2 = 5;

// Define gesture thresholds
const int tiltThreshold = 10; // Adjust as needed

void setup() {
  // Initialize serial communication
  Serial.begin(9600);

  // Initialize MPU6050 sensor
  Wire.begin();
  mpu.initialize();

  // Check if the MPU6050 is connected
  if (!mpu.testConnection()) {
    Serial.println("MPU6050 connection failed");
    while (1);
  }

  // Set the pin modes for the motor driver
  pinMode(motorA1, OUTPUT);
  pinMode(motorA2, OUTPUT);
  pinMode(motorB1, OUTPUT);
  pinMode(motorB2, OUTPUT);
}

void loop() {
  // Read accelerometer and gyroscope values
  int16_t ax, ay, az;
  int16_t gx, gy, gz;
  mpu.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);

  // Print values to the serial monitor for debugging
  Serial.print("ax: "); Serial.print(ax); 
  Serial.print(" ay: "); Serial.print(ay);
  Serial.print(" az: "); Serial.print(az);
  Serial.print(" gx: "); Serial.print(gx);
  Serial.print(" gy: "); Serial.print(gy);
  Serial.print(" gz: "); Serial.println(gz);

  // Gesture control based on tilt
  if (ax > tiltThreshold) {
    moveForward();
  } else if (ax < -tiltThreshold) {
    moveBackward();
  } else if (ay > tiltThreshold) {
    turnLeft();
  } else if (ay < -tiltThreshold) {
    turnRight();
  } else {
    stopMotors();
  }

  // Small delay before the next reading
  delay(100);
}

void moveForward() {
  digitalWrite(motorA1, HIGH);
  digitalWrite(motorA2, LOW);
  digitalWrite(motorB1, HIGH);
  digitalWrite(motorB2, LOW);
}

void moveBackward() {
  digitalWrite(motorA1, LOW);
  digitalWrite(motorA2, HIGH);
  digitalWrite(motorB1, LOW);
  digitalWrite(motorB2, HIGH);
}

void turnLeft() {
  digitalWrite(motorA1, LOW);
  digitalWrite(motorA2, HIGH);
  digitalWrite(motorB1, HIGH);
  digitalWrite(motorB2, LOW);
}

void turnRight() {
  digitalWrite(motorA1, HIGH);
  digitalWrite(motorA2, LOW);
  digitalWrite(motorB1, LOW);
  digitalWrite(motorB2, HIGH);
}

void stopMotors() {
  digitalWrite(motorA1, LOW);
  digitalWrite(motorA2, LOW);
  digitalWrite(motorB1, LOW);
  digitalWrite(motorB2, LOW);
}
