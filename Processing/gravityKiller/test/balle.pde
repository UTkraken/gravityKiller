class Balle {
  float x,y,v;
  
  Balle(float xParam, float yParam, float vParam ){
    x = xParam;
    y = yParam;
    v = vParam;
  }
  
  void balleDisplay(){
    imageMode( CENTER );
    image(balle, x, y);
    imageMode( CORNER ); 
  }
  
  void balleMove(){
    y -= v;
  }
}
