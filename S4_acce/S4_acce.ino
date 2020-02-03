int axeX,axeY,axeZ;

int smoothX =0;
int smoothY = 0;
int smoothZ = 0;

int deltaX = 67;
int deltaY = 66;
int treshold = 360; //Valeur seuil quand on secoue l'arduino de haut en bas

const int pinX = A2;
const int pinY = A1;
const int pinZ = A0;

const int butt = 10;
int valButt;


void setup() {
  Serial.begin(9600);
  pinMode(pinX,INPUT);
  pinMode(pinY,INPUT);
  pinMode(pinZ,INPUT);
  pinMode(butt,INPUT);
}

void loop() {
  //On lit toutes les valeurs analogiques de notre accéléromètre
  axeX = analogRead(pinX);
  axeY = analogRead(pinY);
  axeZ = analogRead(pinZ);
  //Lissage des valeurs, pour éliminer le bruit blanc
  smoothX = smoothX + ((axeX-smoothX)/3);
  smoothY = smoothY + ((axeY-smoothY)/3);
  smoothZ = smoothZ + ((axeZ-smoothZ)/3);
  
  //Envoi des valeurs sur le port série, séparées par des virgules qui seront prises en compte par processing
  Serial.print(smoothX);
  Serial.print(",");
  Serial.print(smoothY);
  Serial.print(",");
  Serial.print(smoothZ);
  Serial.print(",");
  //On envoie en fin de message un 0 ou 1 selon si le boutton est pressé
  if (digitalRead(butt) == 0) {
    Serial.println(0);
  } else {
    Serial.println(1);
  }
  //Petit delay pour ne pas faire surchauffer notre petite Arduino
  delay(100);

}
