/* 
 *  Yvan Gimard 
 *  2020
 */


int axeX,axeY,axeZ;

int smoothX = 0;
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
int gauche = 370; //Valeur qui, une fois dépassée, indique que le gant est incliné vers la gauche
int droite = 350;
int avant = 340;
int arriere = 365;

const int pinX = A0;
const int pinY = A1;
const int pinZ = A2;


const int butt1 = 6;


const int padLeft = 2;
const int padUp = 3;
const int padRight = 4;
const int padDown = 5;

void setup() {
  Serial.begin(9600);
  pinMode(pinX,INPUT);
  pinMode(pinY,INPUT);
  pinMode(pinZ,INPUT);
  pinMode(butt1,INPUT_PULLUP);
  pinMode(padLeft,INPUT_PULLUP);
  pinMode(padUp,INPUT_PULLUP);
  pinMode(padRight,INPUT_PULLUP);
  pinMode(padDown,INPUT_PULLUP);
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
//  if (smoothX < gauche && smoothX > droite && smoothY > avant && smoothY < arriere){
//    Serial.println("NEUTRE");
//  }
//  
// /* ------------------------------------------------------------
// *  POSITION GAUCHE
// *  ------------------------------------------------------------
// */
//  if (smoothX > gauche){    
//    if ( smoothY < avant) {
//      Serial.println("GAUCHE AVANT");
//    } else if (smoothY > arriere) {
//      Serial.println("GAUCHE ARRIERE");
//    } else {
//      Serial.println("GAUCHE");
//    }
//  }
//  
// /* ------------------------------------------------------------
// *  POSITION DROITE
// *  ------------------------------------------------------------
// */
//  else if (smoothX < droite){    
//    if ( smoothY < avant) {
//      Serial.println("DROITE AVANT");
//    } else if (smoothY > arriere) {
//      Serial.println("DROITE ARRIERE");
//    } else {
//      Serial.println("DROITE");
//    }
//  }
//  
// /* ------------------------------------------------------------
// *  POSITION AVANT
// *  ------------------------------------------------------------
// */
//  else if (smoothY < avant){    
//      Serial.println("AVANT");
//  }
//  
// /* ------------------------------------------------------------
// *  POSITION ARRIERE
// *  ------------------------------------------------------------
// */
//  else if (smoothY > arriere){    
//      Serial.println("ARRIERE");
//  }
//  
  //Envoi des valeurs sur le port série, séparées par des virgules qui seront prises en compte par processing
  Serial.print(smoothX);
  Serial.print(",");
  Serial.print(smoothY);
  Serial.print(",");
  Serial.print(smoothZ);
  Serial.print(",");
  
//  On envoie ensuite un 0 ou 1 selon si le boutton est pressé. 0 par défaut
  if (digitalRead(butt1) == 0) {
   Serial.print(1);
   delay(50);
  } else {
      Serial.print(0);
  }
    Serial.print(",");
//Lecture des boutons du pad directionnel
    if (digitalRead(padLeft) == 0) {
     Serial.print(1);
    } else {
        Serial.print(0);
      }
    
    Serial.print(",");
    if (digitalRead(padUp) == 0) {
       Serial.print(1);
    } else {
        Serial.print(0);
      }
    
    Serial.print(",");
    if (digitalRead(padRight) == 0) {
     Serial.print(1);
    } else {
        Serial.print(0);
      }
    
    Serial.print(",");
    if (digitalRead(padDown) == 0) {
     Serial.println(1);
  } else {
      Serial.println(0);
    }



  
  //Petit delay pour ne pas faire surchauffer notre petite Arduino
  delay(5);
  
}
