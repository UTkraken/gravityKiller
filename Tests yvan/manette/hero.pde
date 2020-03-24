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
  
  int gauche = 370;
  int avant = 340;
  int droite = 350;
  int arriere = 365;
  
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
    print(xvalueRaw);
    print(',');
    println(yvalueRaw);
    
 /* ------------------------------------------------------------
 *  POSITION GAUCHE
 *  ------------------------------------------------------------
 */
  if (xvalueRaw > gauche){    
    if ( yvalueRaw < avant) {
      println("GAUCHE AVANT");
      angleHero = 180;
    } else if (yvalueRaw > arriere) {
      println("GAUCHE ARRIERE");
      angleHero = 145;
    } else {
      println("GAUCHE");
    }
  }
  
 /* ------------------------------------------------------------
 *  POSITION DROITE
 *  ------------------------------------------------------------
 */
  else if (xvalueRaw < droite){    
    if ( yvalueRaw < avant) {
      println("DROITE AVANT");
    } else if (yvalueRaw > arriere) {
      println("DROITE ARRIERE");
    } else {
     println("DROITE");
    }
  }
  
 /* ------------------------------------------------------------
 *  POSITION AVANT
 *  ------------------------------------------------------------
 */
  else if (yvalueRaw < avant){    
      println("AVANT");
  }
  
 /* ------------------------------------------------------------
 *  POSITION ARRIERE
 *  ------------------------------------------------------------
 */
  else if (yvalueRaw > arriere){    
      println("ARRIERE");
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
