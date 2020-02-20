float xPers = 300;
float yPers = 300; 

float xBot = 200;
float yBot = 200;

int low = 0;


PImage casque;
PImage balle;
PImage regularTete;

boolean tir = false;


Hero healer = new Hero(25,25,xPers,yPers);
Zombie regular = new Zombie(25,25,25,25,color(0,255,255));


void setup(){
  size(1440,1080);
  casque = loadImage("outfit1.png");
  balle = loadImage("balle.png");
  regularTete = loadImage("regular.png");
}

void draw(){
  background(0);
  
  healer.heroDisplay();
  healer.orientationHero();
  deplacement();
  regular.afficheZombie();
  regular.orientationZombie();
}

void deplacement(){
  if(keyPressed == true){
    if(keyCode == UP) healer.y -= healer.vitesse;
    if(keyCode == DOWN) healer.y += healer.vitesse;
    if(keyCode == LEFT) healer.x -= healer.vitesse;
    if(keyCode == RIGHT) healer.x += healer.vitesse;
  }
  
  if (key == ' ' ) {
    Balle bullet = new Balle(healer.x,healer.y,10);
    
    
    bullet.balleDisplay();
    bullet.balleMove();
  }
  
  xBot += cos(PI * regular.angleZombie / 180)*regular.vitesseZombie;
  yBot += sin(PI * regular.angleZombie /180)*regular.vitesseZombie;
  
  
  
}
