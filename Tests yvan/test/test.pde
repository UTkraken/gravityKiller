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

boolean tir = true;

int bullet_time = 0;   
int currentMillis;
int previousMillis;
int lastShot;
boolean firstShot = true;

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
  lastShot = millis();
}

void draw(){
  background(0);
  
  healer.heroDisplay();
  healer.orientationHero();
  deplacement();
  regular.afficheZombie();
  regular.orientationZombie();
  animation_Tir_Munitions();
  previousMillis = millis();
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
  
  if (mousePressed){
      if ((previousMillis - currentMillis) > 500) { //Vérifier si le dernier tir est trop récent, pour empêcher le joueur de spammer la touche
        dessinerTir();
      }
  } else if (!mousePressed){
    firstShot = true; //repasser le booleen à true pour indiquer que la prochaine balle sera la première du clic
  }
}   

void dessinerTir() {
    
    bullet.x = healer.x;
    bullet.y = healer.y;
    
    if (!firstShot) { //Si on a déjà lancé un projectile, vérifier que x millisecondes se soient écoulées
      if((millis() - currentMillis) > 500) { //Vérifier le temps écoulé depuis le dernier tir
         currentMillis = millis(); 
         Balle nb_balles = new Balle( healer.x + 1, healer.y, healer.angleHero); //On remplit les munitions (nb_balles) à l'intérieur du tableau dynamique bullets 
         bullets.add(nb_balles); 
      }
      //si on vient de cliquer sur la touche, lancer un projectile sans attendre
    } else if (firstShot) {          
         currentMillis = millis(); //Prendre l'instant où la balle est tiré
         Balle nb_balles = new Balle( healer.x + 1, healer.y, healer.angleHero);        
         bullets.add(nb_balles); 
         firstShot = false;    
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
