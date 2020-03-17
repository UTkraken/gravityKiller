class Balle {
  float x,y,v=50;
  float angleBalle=0;
  
  Balle(float xParam, float yParam, float aParam){
    x = xParam;
    y = yParam;
    angleBalle = aParam;
  }
  
  void balleDisplay(){
    imageMode( CENTER );
    image(img_balle, x,y);
    imageMode( CORNER ); 
  }
  
  void balleMove(){
      float dx = cos(PI * angleBalle / 180)*v;
      float dy = sin(PI * angleBalle /180)*v;
      x=dx+x;
      y=dy+y;
  }

}
