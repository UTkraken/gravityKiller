class Zombie {
  // déclaration des paramètres du personnage
  int larg;
  int haut;
  int x;
  int y ;
  color couleur;
  
  float angleZombie = 0;
  float vitesseZombie = 1.8;
  
  
  // constructeur du zombie
  Zombie(int largParam, int hautParam, int xParam, int yParam, color nouvCouleur) {
    larg = largParam;
    haut = hautParam;
    x = xParam;
    y = yParam;
    couleur = nouvCouleur;
  }
  

  void afficheZombie(){
    pushMatrix();
    translate(xBot,yBot);
    rotate(PI * angleZombie / 180 );
    fill(0,255,0);
    ellipse(0,0,30,30);
    fill(255,0,0);
    ellipse(15,0,15,15);
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
