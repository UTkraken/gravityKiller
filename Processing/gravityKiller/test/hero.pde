class Hero {
  // déclaration des paramètres du personnage
  int larg;
  int haut;
  float x;
  float y ;
  
  int vitesse = 3;
  float angleHero=0;
  
  
  // constructeur du hero
  Hero(int largParam, int hautParam, float xParam, float yParam) {
    larg = largParam;
    haut = hautParam;
    x = xParam;
    y = yParam;
  }
  
  
  //dessin du hero
  void heroDisplay(){
    pushMatrix();
    translate(x,y);
    rotate(radians(90));
    rotate(PI * angleHero / 180 );
    imageMode(CENTER);
    image(casque,0,0);
    popMatrix();
  }
  
  void orientationHero(){
    if(mouseY < y){
      angleHero = 90-atan((mouseX - x)/(mouseY - y))*180/PI;
    }
    else{
      angleHero = 270-atan((mouseX - x)/(mouseY - y))*180/PI; 
    }
  }
  
}
