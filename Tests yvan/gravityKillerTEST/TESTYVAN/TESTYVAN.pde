import processing.serial.*;
Serial port;

float xPers = 300;
float yPers = 300; 

float xBot = 200;
float yBot = 200;

// YVAN
float xvalue = 0;
int xValueRaw = 0;
float yvalue = 0;
int yValueRaw = 0;
float zvalue = 0;
int valButt = 0;
int AngleVision=90;
int treshold = 22;
float zvalueLast = 380;
float backColorR = 255;
float backColorG = 255;
float backColorB = 255;
// Fin variables Yvan

Hero healer = new Hero(25,25,xPers,yPers,color(255));
Zombie regular = new Zombie(25,25,25,25,color(0,255,255));

void setup(){
  size(1440,1080);
  port = new Serial(this, "COM10", 9600);
    port.bufferUntil('\n');
}

void draw(){
  background(0);
  
  healer.heroDisplay();
  healer.orientationHero();
  //deplacementAccelero();
  regular.afficheZombie();
  regular.orientationZombie();
}

void deplacementAccelero() {
  if(xValueRaw > 360) { //Gauche
      println("coucou");
      healer.vitesse = map(xValueRaw,361,380,1,3);
       healer.x -= healer.vitesse;
      //TODO : Réduire la vitesse max;
      // Permettre au héro de revenir au point mort
    }
}

void deplacement(){
  //if(keyPressed == true){
  //  if(keyCode == UP) healer.y -= healer.vitesse;    
  //  if(keyCode == DOWN) healer.y += healer.vitesse;
  //  if(keyCode == LEFT) healer.x -= healer.vitesse;
  //  if(keyCode == RIGHT) healer.x += healer.vitesse;
  //}
  
  xBot += cos(PI * regular.angleZombie / 180)*regular.vitesseZombie;
  yBot += sin(PI * regular.angleZombie /180)*regular.vitesseZombie;  
  
}


//Fonctions Yvan
void serialEvent(Serial port) {
    String serialStr = port.readStringUntil('\n');
    serialStr = trim(serialStr);
    int values[] = int(split(serialStr, ','));
    //Récupérer les valeurs du tableau dans des variables
    if( values.length == 10 ) {
        xvalue = calculate( values[0], 329 );      //On passe la valeur dans une variable qui vient la transformer en radians.
        xValueRaw =  values [0];
        yvalue = -calculate( values[1], 331 );
        yValueRaw = values[1];
        zvalue = values [2];
        valButt = values[3];
        
    }
  //Débuguage
    //println(xvalue);
    //print("Valeur X : ");
    //print(xValueRaw);
    //print(" et ");
    //print("Valeur Y : ");
    //println(yValueRaw);
}

float calculate( int returnValue, int baseValue ) {
  int diff = returnValue - baseValue;        //On regarde la valeur de l'inclinaison, en la comparant avec la valeur d'inclinaison au repos
  float resultat = AngleVision*(diff/67.0);
  resultat = resultat*PI/180.0;            //Convertir l'angle en radians
  return resultat;
}

//Fin fonctions yvan
