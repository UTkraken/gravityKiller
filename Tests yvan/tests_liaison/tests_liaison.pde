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
    port = new Serial(this, "COM10", 9600);
    port.bufferUntil('\n');
    background(0);
}

void draw() {
    background(backColorR,backColorG,backColorB);      //Rafraîchir le fond avec nos couleurs rgb stockées dans des variables
    
    //Si on appuie sur le bouton, changer la couleur du cube
    if (valButt == 1) {  
      xvalueRaw = map(xvalueRaw,260,400,0,255);
      fill(xvalueRaw,xvalueRaw,xvalueRaw);
      
    } else {
        fill (0,0,0);
    }
    if ((zvalue - zvalueLast )> treshold) {      //Comparer la valeur actuelle et la valeur précédente, et si un certain écart est dépassé (si un mouvement assez brusque a eu lieu), rentrer dans la boucle
      backColorR=random(255);                    //Générer des valeurs aléatoires pour nos couleurs
      backColorG=random(255);
      backColorB=random(255);
      zvalueLast = zvalue;                      //Mettre à jour la dernière valeur
      println("ARRETER DE ME SECOUER");
      port.write(5);                        //Envoyer un chiffre sur le port série pour activer le buzzer
      
    } else {
      zvalueLast = zvalue;
    }
    stroke(255);
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
    if( values.length == 10 ) {
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
