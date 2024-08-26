#include <Wire.h>
#include <MPU6050.h>

MPU6050 mpu;

const int motorA1 = 2;
const int motorA2 = 3;
const int motorB1 = 4;
const int motorB2 = 5;

const int tiltThreshold = 10;

void setup() {
  Serial.begin(9600);

  Wire.begin();
  mpu.initialize();

  if (!mpu.testConnection()) {
    Serial.println("MPU6050 connection failed");
    while (1);
  }

  pinMode(motorA1, OUTPUT);
  pinMode(motorA2, OUTPUT);
  pinMode(motorB1, OUTPUT);
  pinMode(motorB2, OUTPUT);
}

void loop() {
  int16_t ax, ay, az;
  int16_t gx, gy, gz;
  mpu.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);

  Serial.print("ax: "); Serial.print(ax); 
  Serial.print(" ay: "); Serial.print(ay);
  Serial.print(" az: "); Serial.print(az);
  Serial.print(" gx: "); Serial.print(gx);
  Serial.print(" gy: "); Serial.print(gy);
  Serial.print(" gz: "); Serial.println(gz);

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
