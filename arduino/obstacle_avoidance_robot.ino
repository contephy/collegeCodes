// Define pins for the ultrasonic sensor
const int trigPin = 9;
const int echoPin = 10;

// Define pins for the motor driver
const int motorA1 = 2;
const int motorA2 = 3;
const int motorB1 = 4;
const int motorB2 = 5;

// Define the maximum distance to detect obstacles (in cm)
const int maxDistance = 20;

void setup() {
  // Initialize serial communication
  Serial.begin(9600);

  // Set the pin modes for the ultrasonic sensor
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  // Set the pin modes for the motor driver
  pinMode(motorA1, OUTPUT);
  pinMode(motorA2, OUTPUT);
  pinMode(motorB1, OUTPUT);
  pinMode(motorB2, OUTPUT);
}

void loop() {
  long duration;
  int distance;

  // Trigger the ultrasonic sensor
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Read the echo time
  duration = pulseIn(echoPin, HIGH);

  // Calculate the distance
  distance = duration * 0.0344 / 2;

  // Print the distance to the serial monitor
  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" cm");

  // Move forward if no obstacle is detected within maxDistance
  if (distance > maxDistance) {
    moveForward();
  } else {
    // Stop the motors
    stopMotors();
    // Optionally, implement other behaviors like turning
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

void stopMotors() {
  digitalWrite(motorA1, LOW);
  digitalWrite(motorA2, LOW);
  digitalWrite(motorB1, LOW);
  digitalWrite(motorB2, LOW);
}
