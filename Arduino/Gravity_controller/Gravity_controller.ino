int axeX,axeY,axeZ;

int smoothX =0;
int smoothY = 0;
int smoothZ = 0;

int deltaX = 67;
int deltaY = 66;
int treshold = 360; //Valeur seuil quand on secoue l'arduino de haut en bas

//Valeurs pour l'accéléro des cours
//int gauche = 320; //Valeur qui, une fois dépassé, indique que le gant est incliné vers la gauche
//int droite = 360;
//int avant = 355;
//int arriere = 330;

//Valeurs pour l'accéléro perso
int gauche = 370; //Valeur qui, une fois dépassé, indique que le gant est incliné vers la gauche
int droite = 350;
int avant = 340;
int arriere = 365;

const int pinX = A1;
const int pinY = A2;
const int pinZ = A3;

const int butt1 = 5;
const int butt2 = 6;
const int butt3 = 7;

const int buzz = 11;

void setup() {
  Serial.begin(9600);
  pinMode(pinX,INPUT);
  pinMode(pinY,INPUT);
  pinMode(pinZ,INPUT);
  pinMode(butt1,INPUT_PULLUP);
  pinMode(butt2,INPUT_PULLUP);
  pinMode(butt3,INPUT_PULLUP);
  pinMode(buzz,OUTPUT);
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

 /* ------------------------------------------------------------
 *  POSITION NEUTRE
 *  ------------------------------------------------------------
 */
  if (smoothX < gauche && smoothX > droite && smoothY > avant && smoothY < arriere){
    Serial.println("NEUTRE");
  }
  
 /* ------------------------------------------------------------
 *  POSITION GAUCHE
 *  ------------------------------------------------------------
 */
  if (smoothX > gauche){    
    if ( smoothY < avant) {
      Serial.println("GAUCHE AVANT");
    } else if (smoothY > arriere) {
      Serial.println("GAUCHE ARRIERE");
    } else {
      Serial.println("GAUCHE");
    }
  }
  
 /* ------------------------------------------------------------
 *  POSITION DROITE
 *  ------------------------------------------------------------
 */
  else if (smoothX < droite){    
    if ( smoothY < avant) {
      Serial.println("DROITE AVANT");
    } else if (smoothY > arriere) {
      Serial.println("DROITE ARRIERE");
    } else {
      Serial.println("DROITE");
    }
  }
  
 /* ------------------------------------------------------------
 *  POSITION AVANT
 *  ------------------------------------------------------------
 */
  else if (smoothY < avant){    
      Serial.println("AVANT");
  }
  
 /* ------------------------------------------------------------
 *  POSITION ARRIERE
 *  ------------------------------------------------------------
 */
  else if (smoothY > arriere){    
      Serial.println("ARRIERE");
  }
  
  //Envoi des valeurs sur le port série, séparées par des virgules qui seront prises en compte par processing
//  Serial.print(smoothX);
//  Serial.print(",");
//  Serial.print(smoothY);
//  Serial.print(",");
//  Serial.println(smoothZ);
//  Serial.print(",");
//  //On envoie ensuite un 0 ou 1 selon si le boutton est pressé. 0 par défaut
  if (digitalRead(butt1) == 0) {
  Serial.println("1 est appuyé");
   digitalWrite(buzz,HIGH);    //Si bouton 1 pressé, faire vibrer
   delay(50);
  } else {
     // Serial.println(1);
     digitalWrite(buzz,LOW);  //Sinon, éteindre moteur vibrant
  }
   if (digitalRead(butt2) == 0) {
      Serial.println("2 est appuyé");
  } 
   if (digitalRead(butt3) == 0) {
      Serial.println("3 est appuyé");
  } 

  //Si on reçoit un message sur le port série
  if (Serial.available()>0) {
    if(Serial.read()==5) {
      digitalWrite(buzz,HIGH);    //Si nombre vaut 5, allumer puis éteindre le buzzer
    delay(100);
    digitalWrite(buzz,LOW);
    }
    
  }
  //Petit delay pour ne pas faire surchauffer notre petite Arduino
  delay(50);
  
}
