 int axeX,axeY,axeZ;
const int pinX = A2;
const int pinY = A1;
const int pinZ = A0;


void setup() {
  Serial.begin(9600);
  pinMode(pinX,INPUT);
  pinMode(pinY,INPUT);
  pinMode(pinZ,INPUT);

}

void loop() {
  axeX = analogRead(pinX);
  axeY = analogRead(pinY);
  axeZ = analogRead(pinZ);
  Serial.print(axeX);
  Serial.print(",");
  Serial.print(axeY);
  Serial.print(",");
  Serial.println(axeZ);
  delay(50);

}
