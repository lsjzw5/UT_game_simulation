class MManimation{
  
  PVector pos;
  float speed = 3;
  float scale = .088;
  float zscale = .3;
  int numFrames = 6;
  int currentFrame = 0;
  float animationTimer = 0;
  
  PImage[] zombieRun = new PImage[numFrames];
  PImage[] rzombieRun = new PImage[numFrames];
  PImage[] policeRun = new PImage[numFrames];
  PImage[] rpoliceRun = new PImage[numFrames];
  
  MManimation(){
    
   pos = new PVector(0, 400);
    
   for (int i = 0; i < zombieRun.length; i++) {
      String runName = "images/Run" + nf(i+1) + ".png";
      zombieRun[i] = loadImage(runName);
    }
    for (int i = 0; i < rzombieRun.length; i++) {
      String rrunName = "images/rRun" + nf(i+1) + ".png";
      rzombieRun[i] = loadImage(rrunName);
    }
    for (int i = 0; i < policeRun.length; i++) {
      String polRunName = "images/run/polRun" + nf(i+1) + ".png";
      policeRun[i] = loadImage(polRunName);
    }
    for (int i = 0; i < rpoliceRun.length; i++) {
      String rpolRunName = "images/run/rpolRun" + nf(i+1) + ".png";
      rpoliceRun[i] = loadImage(rpolRunName);
    } 
  }
  
  void display(){
    if ((millis() - animationTimer) >= 90) {
      currentFrame = (currentFrame + 1) % numFrames;
      animationTimer = millis();
    }
    if(pos.x - 160 > width){
     speed = -speed;
     pos.y = random(350, 450);
      
    }
    if(pos.x < -100){
     speed = -speed;
     pos.y = random(350, 450);
      
    }
    if(speed > 0){
       pos.x += speed;
       image(policeRun[currentFrame], pos.x - 150, pos.y, policeRun[currentFrame].width*scale, policeRun[currentFrame].height*scale);
       image(zombieRun[currentFrame], pos.x, pos.y, rzombieRun[currentFrame].width*zscale, rzombieRun[currentFrame].height*zscale);
     
    }
    if(speed < 0){
       image(rzombieRun[currentFrame], pos.x, pos.y, rzombieRun[currentFrame].width*zscale, rzombieRun[currentFrame].height*zscale);
       image(rpoliceRun[currentFrame], pos.x - 150, pos.y, rpoliceRun[currentFrame].width*scale, rpoliceRun[currentFrame].height*scale);
       pos.x += speed;
    }
  
}

}
