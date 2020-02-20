class Hero {
  // déclaration des paramètres du personnage
  int larg;
  int haut;
  float x;
  float y ;
  color couleur;
  float vitesse = 3.;
  float angleHero=0;
  int xBaseline = 343;
  int yBaseline = 334;
  float angleX = 0.;
  float angleY = 0.;
  
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
  
  //mapper la position de l'accéléro par rapport à la taille de l'écran, ça permet de simuler une souris qui se balade sur l'écran grâce aux valeurs de l'accéléro
  
  void orientationHero(){
    //angleHero = 90-atan((xValueRaw - x)/(yValueRaw - y))*180/PI;
    //if(yValueRaw < 350) {
        //angleHero = -atan((xValueRaw - x)/(yValueRaw - y))*180/PI;
        angleX = map(xValueRaw,380,306,0,1440);
        angleHero = 90-atan((angleX - x)/(angleY - y))*180/PI;
        //println(angleX);
        angleY = map(yValueRaw,365,305,1080,0);
        if(angleY > y){
          
        angleHero = 90-atan((angleX - x)/(angleY - y))*180/PI;
        println(angleY);
        } else {
          angleHero = 270-atan((mouseX - x)/(mouseY - y))*180/PI; 
        }
        
        
        //println(angleHero);
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
