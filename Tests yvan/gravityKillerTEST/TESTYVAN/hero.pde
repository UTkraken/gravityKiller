class Hero {
  // déclaration des paramètres du personnage
  int larg;
  int haut;
  float x;
  float y ;
  color couleur;
  float vitesse = 3.;
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
    //angleHero = 90-atan((xValueRaw - x)/(yValueRaw - y))*180/PI;
    //if(yValueRaw < 350) {
        angleHero = -atan((xValueRaw - x)/(yValueRaw - y))*180/PI;
      //}

    //if(mouseY > y){      
    //  //utiliser ces fonctions pour orienter le héro en fonction de la positio du joystick
    //  angleHero = 90-atan((mouseX - x)/(mouseY - y))*180/PI;
    ////  println(angleHero);
    //}
    //else{
    //  angleHero = 270-atan((mouseX - x)/(mouseY - y))*180/PI; 
    //  //println(angleHero);
    //}
  }
}
