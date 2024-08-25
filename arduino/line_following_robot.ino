// Define the pins for the sensors and motors
#define RIGHT_SENSOR_PIN A0
#define LEFT_SENSOR_PIN A1
#define RIGHT_MOTOR_FORWARD_PIN 9
#define RIGHT_MOTOR_BACKWARD_PIN 10
#define LEFT_MOTOR_FORWARD_PIN 6
#define LEFT_MOTOR_BACKWARD_PIN 5

// Threshold for detecting the line (adjust based on your sensors)
int threshold = 500;

void setup() {
  // Set the motor pins as output
  pinMode(RIGHT_MOTOR_FORWARD_PIN, OUTPUT);
  pinMode(RIGHT_MOTOR_BACKWARD_PIN, OUTPUT);
  pinMode(LEFT_MOTOR_FORWARD_PIN, OUTPUT);
  pinMode(LEFT_MOTOR_BACKWARD_PIN, OUTPUT);

  // Set the sensor pins as input
  pinMode(RIGHT_SENSOR_PIN, INPUT);
  pinMode(LEFT_SENSOR_PIN, INPUT);

  // Initialize the serial monitor (optional, for debugging)
  Serial.begin(9600);
}

void loop() {
  // Read the sensor values
  int rightSensorValue = analogRead(RIGHT_SENSOR_PIN);
  int leftSensorValue = analogRead(LEFT_SENSOR_PIN);

  // Print sensor values to the serial monitor (optional, for debugging)
  Serial.print("Right Sensor: ");
  Serial.print(rightSensorValue);
  Serial.print(" | Left Sensor: ");
  Serial.println(leftSensorValue);

  // Both sensors on the line, move forward
  if (rightSensorValue > threshold && leftSensorValue > threshold) {
    moveForward();
  }
  // Right sensor off the line, turn right
  else if (rightSensorValue < threshold && leftSensorValue > threshold) {
    turnRight();
  }
  // Left sensor off the line, turn left
  else if (rightSensorValue > threshold && leftSensorValue < threshold) {
    turnLeft();
  }
  // Both sensors off the line, stop (optional)
  else {
    stopRobot();
  }

  delay(10);  // Small delay to prevent jitter
}

void moveForward() {
  digitalWrite(RIGHT_MOTOR_FORWARD_PIN, HIGH);
  digitalWrite(RIGHT_MOTOR_BACKWARD_PIN, LOW);
  digitalWrite(LEFT_MOTOR_FORWARD_PIN, HIGH);
  digitalWrite(LEFT_MOTOR_BACKWARD_PIN, LOW);
}

void turnRight() {
  digitalWrite(RIGHT_MOTOR_FORWARD_PIN, LOW);
  digitalWrite(RIGHT_MOTOR_BACKWARD_PIN, HIGH);  // Move right motor backward
  digitalWrite(LEFT_MOTOR_FORWARD_PIN, HIGH);    // Move left motor forward
  digitalWrite(LEFT_MOTOR_BACKWARD_PIN, LOW);
}

void turnLeft() {
  digitalWrite(RIGHT_MOTOR_FORWARD_PIN, HIGH);   // Move right motor forward
  digitalWrite(RIGHT_MOTOR_BACKWARD_PIN, LOW);
  digitalWrite(LEFT_MOTOR_FORWARD_PIN, LOW);
  digitalWrite(LEFT_MOTOR_BACKWARD_PIN, HIGH);   // Move left motor backward
}

void stopRobot() {
  digitalWrite(RIGHT_MOTOR_FORWARD_PIN, LOW);
  digitalWrite(RIGHT_MOTOR_BACKWARD_PIN, LOW);
  digitalWrite(LEFT_MOTOR_FORWARD_PIN, LOW);
  digitalWrite(LEFT_MOTOR_BACKWARD_PIN, LOW);
}
