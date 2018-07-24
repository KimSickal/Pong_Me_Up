class Ball {
  float x = 0;
  float y = 0;
  //sprite
  color bColor = 255;
  int rad = 10;
  
  float angle;
  
  
  float speed = 2;
  
  private boolean inv = false;
  private int counter = 0;
  
  
  Ball(float cx, float cy, int radius, float theta){
    x = cx;
    y = cy;
    rad = radius;
    angle = theta;
  }
  
  void display(){
    stroke(255);
    fill(bColor);
    rectMode(CENTER);
    ellipse(x,y,rad,rad);
    if(inv){
      counter += 1;
      if(counter >= 100){
        counter = 0;
        inv = false;
      }
    }
  }
  
  void move(){
    x = x + speed * cos(radians(angle));
    y = y + speed * sin(radians(angle));
    
  }
  void reflect(boolean isH){
    if(!inv){
      if(isH){
        angle = 180-angle;
      }
      else{
        
        angle =  -angle;
        angle += random(-20, 20);
      }
      inv = true;
    }
  }
  
}