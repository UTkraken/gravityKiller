import processing.serial.*;

Serial port;
float xvalue = 0;
float yvalue = 0;
float zvalue = 0;
int xvalueRaw = 0;
int yvalueRaw = 0;
int valButt = 0;
int AngleVision=90;
int buttLeft, buttUp, buttRight, buttDown;


float xPers = 300;
float yPers = 300; 

//float xBot = 200;
//float yBot = 200;

float xBalle = 0;
float yBalle = 0;

int low = 0;
int v = 50;
int chargeur = 6;

PImage casque;
PImage regularTete;
PImage img_balle;

boolean tir = true;
boolean toucher = false;

int bullet_time = 0;   
int currentMillis;
int previousMillis;
int lastShot;
boolean firstShot = true;

ArrayList <Zombie> zombieArray; //Déclaration du tableau contenant les zombies
int nombreZombie = 0;
ArrayList <Balle> bullets; 

int score = 0;
int waveCompt = 0;
int wave = 1;
int vie =5;

Hero healer = new Hero(25,25,xPers,yPers);
Balle bullet;



void setup(){
  size(1440,1080);
  port = new Serial(this, "COM6", 9600);
    port.bufferUntil('\n');
  casque = loadImage("outfit1.png");
  img_balle = loadImage("balle.png");
  regularTete = loadImage("regular.png");
  bullet = new Balle(healer.x, healer.y, healer.angleHero);  
  bullets = new ArrayList() ;
  lastShot = millis();
  zombieArray = new ArrayList();
  randomSpawn(nombreZombie);
  spawn();
  waveCompt = nombreZombie;
}

void draw(){
  background(0);
  fill(255);
  String comptz="zombie tué: "+ score ;
  textSize(32);
  text(comptz,50,50);
  String cptw = " Wave: "+ wave;
  text(cptw,1250,50);
  String cptv = "Vies: " +vie;
  text(cptv,700,50);
  healer.heroDisplay();
  healer.orientationHero();
  deplacement();
  animation_Tir_Munitions();
  previousMillis = millis(); //Capture de l'instant en millisecondes, utilisé dans mousePressed pour empêcher le spam du tir
    //tir
  if (mousePressed){
      if ((previousMillis - currentMillis) > 500) { //Vérifier si le dernier tir est trop récent, pour empêcher le joueur de spammer la touche
        dessinerTir();
      }
  } else if (!mousePressed){
    firstShot = true; //repasser le booleen à true pour indiquer que la prochaine balle sera la première du clic
  }
  collision();
  if(waveCompt == 0){
    newWave();
  }
}


void deplacement(){
  if(keyPressed == true){
    if(keyCode == UP) healer.y -= healer.vitesse;
    if(keyCode == DOWN) healer.y += healer.vitesse;
    if(keyCode == LEFT) healer.x -= healer.vitesse;
    if(keyCode == RIGHT) healer.x += healer.vitesse;
  }
  

    if(buttUp == 1) {
      healer.y -= healer.vitesse;
      println("HAUT");
    }
    if(buttDown == 1) healer.y += healer.vitesse;
    if(buttLeft == 1) healer.x -= healer.vitesse;
    if(buttRight == 1) healer.x += healer.vitesse;

  
   //Déplacement des zombies
    for (int i = zombieArray.size () - 1; i >= 0; i--) {
      zombieArray.get(i).xBot += cos(PI * zombieArray.get(i).angleZombie / 180)*zombieArray.get(i).vitesseZombie;
      zombieArray.get(i).yBot += sin(PI * zombieArray.get(i).angleZombie /180)*zombieArray.get(i).vitesseZombie;
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
    
   }
 }
 
 
 void collision(){
   for ( int i = zombieArray.size () - 1; i >= 0; i-- ) { 
    //  on obtient les munitions du tableau bullets : bullets.get( i )
    Zombie z = (Zombie) zombieArray.get( i );  
    z.orientationZombie();      //  On lance la méthode orientation du zombie
    z.afficheZombie();   //  On lance la méthode display de zombie
    
    for (int j = bullets.size () - 1; j >= 0; j--){
      //if (bullets.get(j).x > z.xBot && bullets.get(j).x < z.xBot + 25 && bullets.get(j).y > z.yBot && bullets.get(j).y < z.yBot+ 25){
        
        //Comparer les coordonées x et y de la balle et du zombie. Si cette valeur est inférieure au rayon du cercle que forme la hitbox du zombie, ça veut dire que la balle est dans la hitbox
        if(dist(bullets.get(j).x, bullets.get(j).y, z.xBot, z.yBot) < 75){   //remplacer 75 par la taille de la hitbox du zombie      
          //println("touché");
          bullets.remove(j);
          zombieArray.remove(i);
          score++;
          waveCompt--;
       }
    }    
  }
}

void spawn(){
  //Instancer les objets en utilisant la classe Zombie (largeur,hauteur, 
  for (int i=0; i<nombreZombie; i++) {
    float randomPosX = random(width); //Générer des positions aléatoires, prévoir une distance minimale avec le joueur pour pas qu'ils apparaissent sur lui
    float randomPosY = random(height); 
    //println(randomPosX);
    Zombie zomb = new Zombie(25,25,randomPosX,randomPosY);
    zombieArray.add(zomb);
  }
}

void randomSpawn(int result){
  result = int(random(1,5));
  nombreZombie = result + nombreZombie;
  println(nombreZombie);
}

void newWave(){
    wave++;
    randomSpawn(nombreZombie);
    waveCompt =nombreZombie;
    spawn();
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
        yvalueRaw = values[1];
        zvalue = values [2];
        valButt = values[3];        
        buttLeft = values[8];
        buttUp = values[7];
        buttRight = values[6];
        buttDown = values[9];
        
        
    }
  //Débuguage
    //println(yvalueRaw);
    //println(xvalueRaw);
}

float calculate( int returnValue, int baseValue ) {
  int diff = returnValue - baseValue;        //On regarde la valeur de l'inclinaison, en la comparant avec la valeur d'inclinaison au repos
  float resultat = AngleVision*(diff/67.0);
  resultat = resultat*PI/180.0;            //Convertir l'angle en radians
  return resultat;
}
