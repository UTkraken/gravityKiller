import processing.serial.*;

Serial port;

float xvalue = 0;
float yvalue = 0;
int AngleVision=90;

void setup() {
    size(800, 800, P3D);
    //port = new Serial(this, "/dev/cu.usbmodem143411", 9600);
    port = new Serial(this, "COM3", 9600);
    port.bufferUntil('\n');
}

void draw() {
    background(0);
    stroke(255);
    fill(255,255,255);
    translate(width/2,height/2,0);
    lights();
    rotateX(-xvalue/10);
    rotateY(-yvalue/10);
    box(350,350,350);
    delay(20);
}

void serialEvent(Serial port) {
    String serialStr = port.readStringUntil('\n');
    serialStr = trim(serialStr);
    int values[] = int(split(serialStr, ','));
    if( values.length == 3 ) {
        xvalue = calculate( values[0], 328 );
        yvalue = -calculate( values[1], 332 );
    }
    //if( values.length == 3 ) {
    //    xvalue =values [0];
    //    yvalue =values[1];
    //}
    println(xvalue);
    println(yvalue);
}

float calculate( int returnValue, int baseValue ) {
  int diff = returnValue - baseValue;
  float resultat = (AngleVision*diff)/70.0;
  resultat = resultat*PI/180.0;
  //resultat = round(resultat*100);
  //resultat=resultat/100;
  return returnValue;
}
