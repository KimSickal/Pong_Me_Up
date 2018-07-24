class Car {
  float x = 0;
  float y = 0;
  PImage sprite;
  color bColor = 0;
  int bWidth = 10;
  int bHeight = 50;
  
  
  private float speed = 0;
  float acc = 1;
  float maxSpeed = 10;
  
  
  Car(float cx, float cy, int cWidth, int cHeight){
    x = cx;
    y = cy;
    bWidth = cWidth;
    bHeight = cHeight;
  }
  
  Car(float cx, float cy, int cWidth, int cHeight, float cAcc, float cSpeed, String spriteName){
    x = cx;
    y = cy;
    bWidth = cWidth;
    bHeight = cHeight;
    acc = cAcc;
    maxSpeed = cSpeed;
    if(spriteName != null)
      sprite = loadImage(spriteName);
  }
  
  void display(){
    stroke(0);
    fill(bColor);
    if(sprite == null){
      rectMode(CENTER);
      rect(x,y,bWidth,bHeight);
    }
    else{
      image(sprite, x-100, y-100, 200, 200);
    }
  }
  
  void loud(boolean isLeft){
     
  }
  
  void move(int newY){
    float diff = newY - y;
    if(diff >= 0){
      if(diff <= speed + acc){
        y = newY;
        speed = 0;
      }
      else{
        speed =  min(speed+acc, maxSpeed);
        y = y + speed;
      }
    }
    else{
      if(diff >= speed - acc){
        y = newY;
        speed = 0;
      }
      else{
        speed = max(speed-acc, -1*maxSpeed);
        y = y + speed;
      }
    }
  }
}