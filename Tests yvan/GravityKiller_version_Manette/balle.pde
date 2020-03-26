class Balle {
  float x,y,v=50;
  float angleBalle=0;
  float rayon = 5;
  
  Balle(float xParam, float yParam, float aParam){
    x = xParam;
    y = yParam;
    angleBalle = aParam;
  }
  
  void balleDisplay(){   imageMode( CENTER );
   image(img_balle, x,y);
   imageMode( CORNER ); 
    //fill(0,0,255);
    //ellipse(x,y,25,25);
  }
  
  void balleMove(){
      //float dx = cos(PI * angleBalle / 180)*v;
      float dx = cos(angleBalle)*v;
      //float dy = sin(PI * angleBalle /180)*v;
      float dy = sin(angleBalle)*v;
      x=dx+x;
      y=dy+y;
  }
}
