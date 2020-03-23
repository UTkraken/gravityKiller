import ddf.minim.*;

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
int vie = 100;
int point;
int record = 0;

boolean gameOver = false;
boolean game = false;
boolean home = true;

Minim minim;
AudioPlayer songIntro;
AudioPlayer songJeu;
AudioPlayer songGameOver;
AudioSample gunShot;
AudioSample zombieDeath;
AudioSample damage;


Hero healer = new Hero(25,25,xPers,yPers);
Balle bullet;



void setup(){
  size(1920,1280);
  casque = loadImage("outfit1.png");
  img_balle = loadImage("balle.png");
  regularTete = loadImage("regular.png");
  minim = new Minim(this);
  songIntro = minim.loadFile("asbh.mp3");
  songJeu = minim.loadFile("lftk_aa.mp3");
  songGameOver = minim.loadFile("log_walk.mp3");
  gunShot = minim.loadSample("gunshot.mp3");
  zombieDeath = minim.loadSample("zombie_Die.mp3");
  damage = minim.loadSample("damage.mp3");
  bullet = new Balle(healer.x, healer.y, healer.angleHero);  
  bullets = new ArrayList() ;
  lastShot = millis();
  zombieArray = new ArrayList();
  randomSpawn(nombreZombie);
  spawn();
  waveCompt = nombreZombie;
}

void draw(){
  
  if(home){
    game = false;
    gameOver = false;
    background(0);
    textSize(200);
    text("Gravity Killer",100,350);
    rect(450,500,550,100);
    songIntro.play();
    if(mousePressed && mouseX >450 && mouseX < 1000 && mouseY > 500 && mouseY < 600){
      home = false;
      game = true;
      gameOver =false;
    }   
  }
  
  if(game){
    home = false;
    gameOver = false;
    songJeu.play();
    songIntro.close();
    songGameOver.close();
    background(0);
    fill(255);
    String comptz="zombie tué: "+ score ;
    textSize(32);
    text(comptz,50,50);
    String cptw = " Wave: "+ wave;
    text(cptw,1250,50);
    String cptv = "Vies: " +vie+"%";
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
          gunShot.trigger();
        }
    } else if (!mousePressed){
      firstShot = true; //repasser le booleen à true pour indiquer que la prochaine balle sera la première du clic
    }
    
    collision();
    if(waveCompt == 0){
      newWave();
    }
    perteVie();
  }
  
  if(gameOver){
    home = false;
    game = false;
    songGameOver.play();
    background(0);
    textSize(200);
    text("Game Over",200,450);
    textSize(50);
    String finalw ="Vous avez atteint la vage " + wave + " en tuant " + score + " zombies";
    text(finalw,150,520);
    point = wave*score;
    rect(450,700,550,100);
    endGame();
    if(mousePressed && mouseX >450 && mouseX < 1000 && mouseY > 700 && mouseY < 800){
      home = false;
      game = true;
      gameOver = false;
      vie = 100;
      score =0;
      wave = 0;
      nombreZombie =0;
      waveCompt = 0;
      for ( int i = zombieArray.size () - 1; i >= 0; i-- ) {
        zombieArray.remove(i);
      }
      zombieArray.clear();
      newWave();
    }
  }
}


void deplacement(){
  if(keyPressed == true){
    if(keyCode == UP) healer.y -= healer.vitesse;
    if(keyCode == DOWN) healer.y += healer.vitesse;
    if(keyCode == LEFT) healer.x -= healer.vitesse;
    if(keyCode == RIGHT) healer.x += healer.vitesse;
  }
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
          println("touché");
          bullets.remove(j);
          zombieArray.remove(i);
          
          zombieDeath.trigger();
          score++;
          waveCompt--;
       }
    }    
  }
}


void perteVie(){
  for ( int i = zombieArray.size () - 1; i >= 0; i-- ) { 
    if(dist(healer.x,healer.y, zombieArray.get(i).xBot, zombieArray.get(i).yBot)<75){
        vie--;
        damage.trigger();
        if( vie == 0){
          gameOver = true;
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
    if( vie < 100 ){
      vie = vie+20;
    }
}

void endGame(){
  println(record);
  println(score);
  if(record < point){
    String newRecord = "Bravo, vous avec le nouveau record de: "+ point;
    text(newRecord,250,580);
    record = point;
  }
  else if(record > point){
    String scorel = "Vous avez marqué: " + point;
    text(scorel,250,580);
    String afficheRecord = "Le record est de: "+ record;
    text(afficheRecord,250,620);
  }
    if(record == point){
    String newRecord = "Bravo, vous avec le nouveau record de: "+ point;
    text(newRecord,250,580);
    record = point;
  }
}

void stop(){
  songIntro.close();
  songJeu.close();
  songGameOver.close();
  gunShot.close();
  zombieDeath.close();
  damage.close();
  minim.stop();
  super.stop();
}
