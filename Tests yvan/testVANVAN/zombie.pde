class Zombie {
  // déclaration des paramètres du personnage
  int larg;
  int haut;
  float xBot;
  float yBot;
  float angleZombie = 0;
  float vitesseZombie = 1.8;
  
  
  // constructeur du zombie
  Zombie(int largParam, int hautParam, float xBotParam, float yBotParam) {
    larg = largParam;
    haut = hautParam;

    xBot = xBotParam;
    yBot = yBotParam;
  }
  

  void afficheZombie(){
    pushMatrix();
    translate(xBot,yBot);
    rotate(PI * angleZombie / 180 );
    imageMode(CENTER);
    image(regularTete,0,0,80,80);
    popMatrix();
  }
  
  void orientationZombie(){
    if(yBot < healer.y){
      this.angleZombie = 90-atan((xBot - healer.x)/(yBot - healer.y))*180/PI;  
    }
    else{
      this.angleZombie = 270-atan((xBot - healer.x)/(yBot - healer.y))*180/PI; 
    }
  }
}
