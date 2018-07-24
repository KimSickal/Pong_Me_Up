class Man{
  float x = 0;
  float y = 0;
  
  PImage img;
  
  private int struggle = 10;
  private int timer = 0;
  //private float strDis = 10;
  
  Man(float nx, float ny){
    x = nx;
    y = ny;
    img = loadImage("man.png");
    struggle = int(random(5,15));
  }
  
  void display(){
    timer++;
    if(timer >= 2 * struggle){
      timer = 0;
    }
    if(timer >= struggle){
      rectMode(CENTER);
      image(img, x, y + 2 * struggle - timer, 100, 100);
    }
    else{
      rectMode(CENTER);
      image(img, x, y+timer, 100, 100);
    }
    
     
  }
  
  
  
}