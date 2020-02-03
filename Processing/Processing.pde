import processing.serial.*;

Serial port;

float xvalue = 0;
float yvalue = 0;
float zvalue = 0;
float xvalueRaw = 0;
int valButt = 0;
int AngleVision=90;
//int treshold = 370;
int treshold = 22;
float zvalueLast = 380;
float backColorR = 255;
float backColorG = 255;
float backColorB = 255;

void setup() {
    size(800, 800, P3D);
    port = new Serial(this, "COM3", 9600);
    port.bufferUntil('\n');
    background(0);
}

void draw() {
    background(backColorR,backColorG,backColorB);
    stroke(255);
    //Si on appuie sur le bouton, changer la couleur du cube
    if (valButt == 1) {  
      xvalueRaw = map(xvalueRaw,260,400,0,255);
      fill(xvalueRaw,xvalueRaw,xvalueRaw);
    } else {
        fill (0,0,0);
    }
    if ((zvalue - zvalueLast )> treshold) {      //Comparer la valeur actuelle et la valeur précédente, et si un certain écart est dépassé, rentrer dans la boucle
      backColorR=random(255);
      backColorG=random(255);
      backColorB=random(255);
      zvalueLast = zvalue;
      println("ARRETER DE ME SECOUER");
    } else {
      zvalueLast = zvalue;
    }
    translate(width/2,height/2,0);
    lights();
    rotateX(-xvalue);
    rotateY(yvalue);
    box(350,350,350);
    delay(20);
}

void serialEvent(Serial port) {
    String serialStr = port.readStringUntil('\n');
    serialStr = trim(serialStr);
    int values[] = int(split(serialStr, ','));
    //Récupérer les valeurs du tableau dans des variables
    if( values.length == 4 ) {
        xvalue = calculate( values[0], 329 );      //On passe la valeur dans une variable qui vient la transformer en radians.
        xvalueRaw =  values [0];
        yvalue = -calculate( values[1], 331 );
        zvalue = values [2];
        valButt = values[3];
        
    }
  //Débuguage
    println(xvalue);
    println(xvalueRaw);
}

float calculate( int returnValue, int baseValue ) {
  int diff = returnValue - baseValue;        //On regarde la valeur de l'inclinaison, en la comparant avec la valeur d'inclinaison au repos
  float resultat = AngleVision*(diff/67.0);
  resultat = resultat*PI/180.0;            //Convertir l'angle en radians
  return resultat;
}
