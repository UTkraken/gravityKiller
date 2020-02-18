class Hero {
  // déclaration des paramètres du personnage
  int larg;
  int haut;
  float x;
  float y ;
  color couleur;
  float vitesse = 6;
  float angleHero=0;
  
  
  // constructeur du hero
  Hero(int largParam, int hautParam, float xParam, float yParam, color nouvCouleur) {
    larg = largParam;
    haut = hautParam;
    x = xParam;
    y = yParam;
    couleur = nouvCouleur;
  }
  
  //dessin du hero
  void heroDisplay(){
    pushMatrix();
    fill(couleur);
    ellipse(x,y,larg,haut);
    translate(x,y);
    rotate(PI * angleHero / 180 );
    fill(0,255,0);
    ellipse(15,0,15,15);
    popMatrix();
  }
  
  void orientationHero(){
    if(mouseY < y){
      angleHero = 90-atan((mouseX - x)/(mouseY - y))*180/PI;
    //  println(angleHero);
    }
    else{
      angleHero = 270-atan((mouseX - x)/(mouseY - y))*180/PI; 
      //println(angleHero);
    }
  }
}
