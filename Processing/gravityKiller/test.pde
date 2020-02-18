float xPers = 300;
float yPers = 300; 

float xBot = 200;
float yBot = 200;

Hero healer = new Hero(25,25,xPers,yPers,color(255));
Zombie regular = new Zombie(25,25,25,25,color(0,255,255));

void setup(){
  size(600,600);
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
  
  xBot += cos(PI * regular.angleZombie / 180)*regular.vitesseZombie;
  yBot += sin(PI * regular.angleZombie /180)*regular.vitesseZombie;
  
  
  
}
