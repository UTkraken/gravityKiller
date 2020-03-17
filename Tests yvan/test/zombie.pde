class Zombie {
  // déclaration des paramètres du personnage
  int larg;
  int haut;
  float x;
  float y ;
  
  float angleZombie = 0;
  float vitesseZombie = 1.8;
  
  
  // constructeur du zombie
  Zombie(int largParam, int hautParam, float xParam, float yParam) {
    larg = largParam;
    haut = hautParam;
    x = xParam;
    y = yParam;
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
      regular.angleZombie = 90-atan((xBot - healer.x)/(yBot - healer.y))*180/PI;  
    }
    else{
      regular.angleZombie = 270-atan((xBot - healer.x)/(yBot - healer.y))*180/PI; 
    }
  }
}
