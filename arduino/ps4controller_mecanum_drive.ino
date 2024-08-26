#include <PS4Controller.h>

const int motorA1 = 2;
const int motorA2 = 3;
const int motorB1 = 4;
const int motorB2 = 5;
const int motorC1 = 6;
const int motorC2 = 7;
const int motorD1 = 8;
const int motorD2 = 9;

void setup() {
  pinMode(motorA1, OUTPUT);
  pinMode(motorA2, OUTPUT);
  pinMode(motorB1, OUTPUT);
  pinMode(motorB2, OUTPUT);
  pinMode(motorC1, OUTPUT);
  pinMode(motorC2, OUTPUT);
  pinMode(motorD1, OUTPUT);
  pinMode(motorD2, OUTPUT);

  PS4.begin("xx:xx:xx:xx:xx:xx"); // Replace with your PS4 controller MAC address
  Serial.begin(115200);
}

void loop() {
  if (PS4.isConnected()) {
    int leftX = PS4.LStickX();  
    int leftY = PS4.LStickY();  
    int rightX = PS4.RStickX(); 

    // Mecanum drive calculations
    int frontLeft  = leftY + leftX + rightX;
    int frontRight = leftY - leftX - rightX;
    int rearLeft   = leftY - leftX + rightX;
    int rearRight  = leftY + leftX - rightX;

    setMotorSpeed(motorA1, motorA2, frontLeft);
    setMotorSpeed(motorB1, motorB2, frontRight);
    setMotorSpeed(motorC1, motorC2, rearLeft);
    setMotorSpeed(motorD1, motorD2, rearRight);
  }
}

void setMotorSpeed(int pin1, int pin2, int speed) {
  if (speed > 0) {
    digitalWrite(pin1, HIGH);
    digitalWrite(pin2, LOW);
  } else if (speed < 0) {
    digitalWrite(pin1, LOW);
    digitalWrite(pin2, HIGH);
  } else {
    digitalWrite(pin1, LOW);
    digitalWrite(pin2, LOW);
  }
}
