import processing.serial.*;

Serial port;

float xvalue = 0;
float yvalue = 0;
int AngleVision=90;

void setup() {
    size(800, 800, P3D);
    port = new Serial(this, "/dev/cu.usbmodem143411", 9600);
    port.bufferUntil('\n');
}

void draw() {
    background(0);
    stroke(255);
    fill(255,255,255);
    translate(width/2,height/2,0);
    lights();
    rotateX(-xvalue);
    rotateY(-yvalue);
    box(350,350,350);
    delay(20);
}

void serialEvent(Serial port) {
    String serialStr = port.readStringUntil('\n');
    serialStr = trim(serialStr);
    int values[] = int(split(serialStr, ','));
    //if( values.length == 4 ) {
    //    xvalue =calculate( values[0], 336 );
    //    yvalue = -calculate( values[1], 333 );
    //}
    if( values.length == 3 ) {
        xvalue =values [0];
        yvalue =values[1];
    }
}

//float calculate( float returnValue, int baseValue ) {
//  // A COMPLETER !!!!!
//}
