
import processing.serial.*;

Car car[] = new Car[2];

Ball ball;

Man man[] = {};

PImage background;
PImage title;
PImage pause;
PImage score;
PImage winB;
PImage winR;

int truckSize = 200;

float sensetivity = 0.005;
float noise = 9;

int mode = 3; //1 = mouseTracking;

int scene = 0; // 1 = game, 2 = pause, 3 = score, 4 = Lwin, 5 = Rwin
// 0 = title, 10 = adgust & how to
// 9 = option

int nSample = 64;

int scoreL = 0;
int scoreR = 0;

Serial[] port = new Serial[2];
Serial myPort;
boolean firstContact[]  = {false, false};
int[][] serialInArray = new int[2][nSample];
int serialCount[] = {0, 0}; 

int value[] = {0, 0};
float sum =0;
float meanSum = 0;

//PFont font;

int speed = 10;

float lastPoint[] = {0, 0};

float minScore[] = {80, 80};
float maxScore[] = {0, 0};

private int cp = 0;
private String inputStr = "";


void setup() {
  size(1280, 720);
  car[0] = new Car(100,300,20,truckSize,0.5,5, "truck1.png");
  car[1] = new Car(width-100,300,20,truckSize,0.5,5, "truck2.png");
  ball = new Ball(width/2, height/2, 20, random(-30,30));
  //myPort = new Serial(this, Serial.list()[1], 57600); 
  port[1] = new Serial(this, Serial.list()[1], 57600); 
  port[0] = new Serial(this, Serial.list()[2], 57600); 
  background = loadImage("background.png");
  pause = loadImage("PAUSE.png");
  score = loadImage("SCORE.png");
  winB = loadImage("winB.png");
  winR = loadImage("winR.png");
  title = loadImage("title.png");
  
  //scene = 3;
  
  //man[0] = new Man(400,300);
  
  
  //print(Serial.list());
  
  
}

void draw() {
  //println("sss " , port[0].available());
  if(scene == 0){
    image(title, 0, 0, width, height);
  }
  else if(scene == 1){
    background(255);
    image(background, 0,0,width,height);
    for(int i = 0; i < man.length; i++){
      man[i].display();
    }
    if(mode == 0){
      car[0].move(min(max((int((height + 200) * ((maxScore[0] - max(lastPoint[0],minScore[0])) / (maxScore[0] - minScore[0]))) - 200), 0), height));
      car[1].move(min(max((int((height + 200) * ((maxScore[1] - max(lastPoint[1],minScore[1])) / (maxScore[1] - minScore[1]))) - 200), 0), height));
    }
    else if(mode == 1){
      car[0].move(mouseY);
      car[1].move(mouseX*9/16);
    }
    else if(mode == 3){
      car[0].move(mouseY);
      car[1].move(min(max((int((height + 200) * ((maxScore[1] - lastPoint[1]) / (maxScore[1] - minScore[1]))) - 200), 0), height));
    }
    
    
    ///collision test
    if(ball.x <= 100 && ball.y <= car[0].y + 150 && ball.y >= car[0].y - 150){
      ball.reflect(true);
      ball.speed += 0.7;
      
    }
    else if(ball.x >= width - 100 && ball.y <= car[1].y + 150 && ball.y >= car[1].y - 150){
      ball.reflect(true); 
      ball.speed += 0.7;
    }
    /*
    else if(ball.x <= 100 || ball.x >= width-100){
      ball.reflect(true);
      println("Pong!!");
      
    }
    */
    else if(ball.x >= width - 100){
      scoreL++;
      for(int i = 0; i < scoreL; i++){
        man = (Man[]) append(man,new Man(random(-20,20),random(0,height)));
        //print(man.length, "mans");
        scene = 3;
        if(scoreL >= 5){
          scene = 4;
        }
        ball.y = height/2;
        ball.x = width/2;
        ball.speed = 2;
      }
      
      
    }
    else if(ball.x <= 100){
      scoreR++;
      for(int i = 0; i < scoreR; i++){
        man = (Man[]) append(man,new Man(width - 100 + random(-20,20),random(0,height)));
        //print(man.length, "mans");
        scene = 3;
        if(scoreR >= 5){
          scene = 5;
        }
        ball.y = height/2;
        ball.x = width/2;
        ball.speed = 2;
      }
    }
    if(ball.y <=  20 || ball.y >= height - 20){
      ball.reflect(false);
      println("Pong!");
    }
    ball.move();
    ball.display();
    car[0].display();
    car[1].display();
  }
  else if (scene == 2){
    image(background, 0,0,width,height);
    ball.display();
    car[0].display();
    car[1].display();
    for(int i = 0; i < man.length; i++){
      man[i].display();
    }
    image(pause, 0,0,width,height);
  }
  else if (scene == 3){
    image(background, 0,0,width,height);
    ball.display();
    car[0].display();
    car[1].display();
    for(int i = 0; i < man.length; i++){
      man[i].display();
    }
    image(score, 0 ,0, width, height);
    textSize(120);
    fill(0);
    rectMode(CENTER);
    text(scoreL, width/2-120, height/2+10);
    text(scoreR, width/2+40, height/2+10);
  }
  else if(scene == 4){
    image(winB, 0,0,width,height);
    textSize(120);
    fill(0);
    rectMode(CENTER);
    text(scoreL, width/2-120, height/2+10);
    text(scoreR, width/2+40, height/2+10);
     
  }
  else if(scene == 5){
    image(winR, 0,0,width,height);
    textSize(120);
    fill(0);
    rectMode(CENTER);
    text(scoreL, width/2-120, height/2+10);
    text(scoreR, width/2+40, height/2+10);
  }
  
}

void mouseClicked(){
   if(scene == 0){
     scene = 1;
   }
   else if(scene == 1){
     scene = 2;
   }
   else if(scene == 2){
     scene = 1;
   }
   else if(scene == 3){
     scene = 1; 
     
     minScore[0] = noise;
     minScore[1] = noise;
     maxScore[0] = noise;
     maxScore[1] = noise;
     
   }
   else if(scene == 4 || scene == 5){
     setup();
     scene = 0;
   }
   
   
}

void serialEvent(Serial eventPort){
  inputStr = eventPort.readStringUntil(10);
  if (inputStr != null){
    //println(inputStr);
    inputStr = trim(inputStr);
    String code =inputStr.substring(0,1);
    if( code.equals("A")){
      cp = 0;
    }
    else if(code.equals("B")){
      cp = 1;
    }
    else{
      cp = -1;
    }
    if(cp >= 0){
      if(!firstContact[cp]){
        eventPort.clear();
        firstContact[cp] = true;
        println("contact!");
        eventPort.write("A");
      }
      else{
        serialInArray[cp][serialCount[cp]] = int(inputStr.substring(3, inputStr.length()));
        serialCount[cp]++;
        if(serialCount[cp] > nSample - 1){
          sum = 0;
          meanSum = 0;
          for(int i = 0; i < nSample; i++){
            float factor = (serialInArray[cp][i] / 1024.0) * (serialInArray[cp][i] / 1024.0);
            meanSum += i*factor;
            sum += factor;
          }
          eventPort.write("A");
          serialCount[cp] = 0;
          if(sum > sensetivity){
            if(meanSum / sum < minScore[cp]){
              minScore[cp] = max(meanSum / sum, noise);
              
            }
            if(meanSum / sum > maxScore[cp]){
              maxScore[cp] = meanSum / sum;
            }
            lastPoint[cp] = meanSum / sum;
            println(cp, sum, "\t",  meanSum/(sum), "\t", minScore[cp], "\t", maxScore[cp]);
          }
        }
      }
    }
    
    
  }
}