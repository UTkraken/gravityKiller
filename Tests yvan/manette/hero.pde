class Hero {
  // déclaration des paramètres du personnage
  int larg;
  int haut;
  float x;
  float y ;
  float rayon = 12.5;
  
  int vitesse = 4;
  float angleHero=0;
  
  
  float angleX = 0;
  float angleY = 0;
  
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
    angleX = map(xvalueRaw,280,400,0,1440);
    angleY = map(yvalueRaw,300,450,0, 1080);
    //print(mouseY);
    //print(',');
    //println(angleY);
    if(angleY < y){
      angleHero = 90-atan((angleX - x)/(angleY - y))*180/PI;
      println(angleHero);
    }
    else{
      angleHero = 270-atan((angleY - y)/(angleX - x))*180/PI; 
      println(angleHero);
    }
    
    
    
    
    //if(mouseY < y){
    //  angleHero = 90-atan((mouseX - x)/(mouseY - y))*180/PI;
    //  //println(angleHero);
    //}
    //else{
    //  angleHero = 270-atan((mouseX - x)/(mouseY - y))*180/PI; 
    //  //println(angleHero);
    //}
  }
  
}
