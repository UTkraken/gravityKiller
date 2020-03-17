float xPers = 300;
float yPers = 300; 

float xBot = 200;
float yBot = 200;

float xBalle = 0;
float yBalle = 0;

int low = 0;
int v = 50;
int chargeur = 6;

PImage casque;
PImage regularTete;
PImage img_balle;

boolean tir = false;

int bullet_time = 0;   


Zombie regular = new Zombie(25,25,xBot,yBot); 
ArrayList <Balle> bullets; 

Hero healer = new Hero(25,25,xPers,yPers);
Balle bullet;



void setup(){
  size(1440,1080);
  casque = loadImage("outfit1.png");
  img_balle = loadImage("balle.png");
  regularTete = loadImage("regular.png");
  bullet = new Balle(healer.x, healer.y, healer.angleHero);  
  bullets = new ArrayList() ;
}

void draw(){
  background(0);
  
  healer.heroDisplay();
  healer.orientationHero();
  deplacement();
  mouseClicked();
  regular.afficheZombie();
  regular.orientationZombie();

  animation_Tir_Munitions();
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

void  mouseClicked(){
    tir = true;
 }

void dessinerTir() {

  if (tir ==true) {

    bullet.x = healer.x;
    bullet.y = healer.y;
    
    Balle nb_balles = new Balle( healer.x + 1, healer.y, healer.angleHero);
      //  On remplit les munitions (nb_balles) à l'intérieur du tableau dynamique bullets 
    bullets.add(nb_balles); 
    
  }
}


void animation_Tir_Munitions() {
  //  On parcourt le tableau dynamique <Bullet> bullets
  for ( int i = bullets.size () - 1; i >= 0; i-- ) { 
    //  on obtient les munitions du tableau bullets : bullets.get( i )
    Balle o = (Balle) bullets.get( i );  
    o.balleMove();      //  On lance la méthode move() de Bullet
    o.balleDisplay();   //  On lance la méthode display de Bullet

  }}
