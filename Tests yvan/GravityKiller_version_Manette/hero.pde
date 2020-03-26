class Hero {
  // déclaration des paramètres du personnage
  int larg;
  int haut;
  float x;
  float y ;
  float rayon = 12.5;
  
  int vitesse = 4;
  float angleHero=0;
  
  //Valeurs limites qui permettent de calibrer l'angle nécessaire pour orienter le personnage.
  //Si l'une des orientations du personnage n'est pas précise, on peut modifier ces valeurs pour ajuster
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
    //rotate(PI * angleHero / 180 );
    rotate(angleHero);
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
      angleHero = (5*PI)/4;
    } else if (yvalueRaw > arriere) {
      println("GAUCHE ARRIERE");
      angleHero = (3*PI)/4;
    } else {
      println("GAUCHE");
      angleHero = PI;
    }
  }
  
 /* ------------------------------------------------------------
 *  POSITION DROITE
 *  ------------------------------------------------------------
 */
  else if (xvalueRaw < droite){    
    if ( yvalueRaw < avant) {
      println("DROITE AVANT");
      angleHero = (7*PI)/4;
    } else if (yvalueRaw > arriere) {
      println("DROITE ARRIERE");
      angleHero = PI/4;
    } else {
     println("DROITE");
     angleHero = 0;
    }
  }
  
 /* ------------------------------------------------------------
 *  POSITION AVANT
 *  ------------------------------------------------------------
 */
  else if (yvalueRaw < avant){    
      println("AVANT");
      angleHero = (3*PI)/2;
  }
  
 /* ------------------------------------------------------------
 *  POSITION ARRIERE
 *  ------------------------------------------------------------
 */
  else if (yvalueRaw > arriere){    
      println("ARRIERE");
      angleHero = PI/2;
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
