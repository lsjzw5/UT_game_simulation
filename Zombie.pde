class Zombie {
  int numFrames = 6;
  int deadFrames = 8;
  PImage[] zombieWalk = new PImage[numFrames];
  PImage[] zombieAtk = new PImage[numFrames];
  PImage[] rzombieWalk = new PImage[numFrames];
  PImage[] rzombieAtk = new PImage[numFrames];
  PImage[] zombieDie = new PImage[deadFrames];
  PImage[] rzombieDie = new PImage[deadFrames];

  PVector pos;
  PVector vel;
  float scale;
  float setx;
  int currentFrame = 0;
  int dFrame = 0;
  int deadCount;
  int atkFrame;
  float animationTimer = 0;
  float interval = 100;
  int offset;
  int atkCount;
  boolean status = false;
  boolean drop = false;
  boolean attackMode = false;
  boolean deadMode = false;
  boolean didMove;
  
  Zombie(PVector pos, PVector vel, float scale, int offset) {
    this.pos = pos;
    this.vel = vel;
    setx = vel.x;
    this.scale= scale;
    this.offset = offset;
    currentFrame = offset;
    //Create the animation arrays and save them in the constructor
    for (int i = 0; i < zombieWalk.length; i++) {
      String walkName = "images/Walk" + nf(i+1) + ".png";
      zombieWalk[i] = loadImage(walkName);
    }
    for (int i = 0; i < zombieAtk.length; i++) {
      String atkName = "images/Attack" + nf(i+1) + ".png";
      zombieAtk[i] = loadImage(atkName);
    }
    for (int i = 0; i < zombieWalk.length; i++) {
      String rwalkName = "images/rWalk" + nf(i+1) + ".png";
      rzombieWalk[i] = loadImage(rwalkName);
    }
    for (int i = 0; i < zombieAtk.length; i++) {
      String ratkName = "images/rAttack" + nf(i+1) + ".png";
      rzombieAtk[i] = loadImage(ratkName);
    }
    for (int i = 0; i < zombieDie.length; i++) {
      String deadName = "images/Dead" + nf(i+1) + ".png";
      zombieDie[i] = loadImage(deadName);
    }
    for (int i = 0; i < rzombieDie.length; i++) {
      String rdeadName = "images/rDead" + nf(i+1) + ".png";
      rzombieDie[i] = loadImage(rdeadName);
    }    
  }
  void move() {
    didMove = false;
    if ((millis() - animationTimer) >= interval) {
      currentFrame = (currentFrame + 1) % numFrames;
      animationTimer = millis();
    }
    //down
    if(pos.y + (.5*zombieWalk[1].height*scale) <= player.pos.y){
      if(pos.x + (.5*zombieWalk[1].width*scale) > player.pos.x){
        if(attackMode == false && deadMode == false){
      image(rzombieWalk[currentFrame], pos.x, pos.y, zombieWalk[currentFrame].width*scale, zombieWalk[currentFrame].height*scale);
       vel.x = -setx;
       if(pos.x + (.5*zombieWalk[1].width*scale) > player.pos.x -15 && pos.x + (.5*zombieWalk[1].width*scale) < player.pos.x+15){
       pos.x -= 0;
       pos.y += vel.y;
       }
       if(pos.y + (.5*zombieWalk[1].width*scale) >  player.pos.y - 27.5 && pos.y + (.5*zombieWalk[1].width*scale) < player.pos.y + 27.5){
          pos.x += vel.x;
          pos.y += 0;
       }
       if(!(pos.y + (.5*zombieWalk[1].width*scale) >  player.pos.y - 27.5 && pos.y + (.5*zombieWalk[1].width*scale) < player.pos.y + 27.5) && !(pos.x + (.5*zombieWalk[1].width*scale) > player.pos.x -15 && pos.x + (.5*zombieWalk[1].width*scale) < player.pos.x+15)){
        pos.x += vel.x/( sqrt(pow(.9,2) + pow(.9,2)));
        pos.y += vel.y/( sqrt(pow(vel.x,2) + pow(vel.y,2))); 
       }  
       }
       didMove = true;
        }
      else{
        if(attackMode == false && deadMode == false){
        image(zombieWalk[currentFrame], pos.x, pos.y, zombieWalk[currentFrame].width*scale, zombieWalk[currentFrame].height*scale);
       vel.x = setx; 
       if(pos.y + (.5*zombieWalk[1].width*scale) >  player.pos.y - 27.5 && pos.y + (.5*zombieWalk[1].width*scale) < player.pos.y + 27.5){
          pos.x += vel.x;
          pos.y += 0;
       }
       else{
         pos.x += vel.x/(sqrt(pow(.9,2) + pow(.9,2)));
        pos.y += vel.y/(sqrt(pow(vel.x,2) + pow(vel.y,2))); 
       }
      didMove = true; 
      }  
    }
  }

     //up
    if(pos.y + (.5*zombieWalk[1].height*scale) >  player.pos.y && didMove == false){
      if(pos.x + (.5*zombieWalk[1].width*scale) > player.pos.x){
      if(attackMode == false && deadMode == false){
       image(rzombieWalk[currentFrame], pos.x, pos.y, zombieWalk[currentFrame].width*scale, zombieWalk[currentFrame].height*scale);
       vel.x = -setx;
       if(pos.x + (.5*zombieWalk[1].width*scale) > player.pos.x -15 && pos.x + (.5*zombieWalk[1].width*scale) < player.pos.x+15){
       pos.x -= 0;
       pos.y -= vel.y;
       }
       if(pos.y + (.5*zombieWalk[1].width*scale) >  player.pos.y - 27.5 && pos.y + (.5*zombieWalk[1].width*scale) < player.pos.y + 27.5){
          pos.x += vel.x;
          pos.y += 0;
       }
       if(!(pos.y + (.5*zombieWalk[1].width*scale) >  player.pos.y - 27.5 && pos.y + (.5*zombieWalk[1].width*scale) < player.pos.y + 27.5) && !(pos.x + (.5*zombieWalk[1].width*scale) > player.pos.x -15 && pos.x + (.5*zombieWalk[1].width*scale) < player.pos.x+15)){
        pos.x += vel.x/(sqrt(pow(.9,2) + pow(.9,2)));
        pos.y -= vel.y/(sqrt(pow(vel.x,2) + pow(vel.y,2))); 
       }  
       }
          }
       else{
         if(attackMode == false && deadMode == false){
          image(zombieWalk[currentFrame], pos.x, pos.y, zombieWalk[currentFrame].width*scale, zombieWalk[currentFrame].height*scale);
       vel.x = setx;
       if(pos.y + (.5*zombieWalk[1].width*scale) >  player.pos.y - 27.5 && pos.y + (.5*zombieWalk[1].width*scale) < player.pos.y + 27.5){
          pos.x += vel.x;
          pos.y += 0;
       }
       else{
         pos.x += vel.x/(sqrt(pow(.9,2) + pow(.9,2)));
        pos.y -= vel.y/(sqrt(pow(vel.x,2) + pow(vel.y,2))); 
       }  
     }
    }
  }
}
  void attack() {
     if ((millis() - animationTimer) >= 350) {
      currentFrame = (currentFrame + 1) % numFrames;
      animationTimer = millis();
    }
      image(zombieAtk[currentFrame], pos.x, pos.y, zombieAtk[currentFrame].width*scale, zombieAtk[currentFrame].height*scale);
    atkCount += 1;
  }

  void rattack() {
      if ((millis() - animationTimer) >= 350) {
      currentFrame = (currentFrame + 1) % numFrames;
      animationTimer = millis();
    }
      image(rzombieAtk[currentFrame], pos.x, pos.y, zombieAtk[currentFrame].width*scale, zombieAtk[currentFrame].height*scale);
    atkCount += 1;
  }
  
  void dead(){
     if ((millis() - animationTimer) >= 55) {
      dFrame = (dFrame + 1) % deadFrames;
      animationTimer = millis();
     }
      image(zombieDie[dFrame], pos.x, pos.y, zombieDie[dFrame].width*scale, zombieDie[dFrame].height*scale);
      deadCount += 1;
    }

  
  void rdead(){
     if ((millis() - animationTimer) >= 55) {
      dFrame = (dFrame + 1) % deadFrames;
      animationTimer = millis();
     }
      image(rzombieDie[dFrame], pos.x, pos.y, rzombieDie[dFrame].width*scale, rzombieDie[dFrame].height*scale);
      deadCount += 1;
    }
    
  
  void bulletCollision() {
    if (deadMode == true) {
      return;
    } 
    else {
      for (int i = playerProjectiles.size() - 1; i >= 0; i--) {
        Projectile bullet = playerProjectiles.get(i);
        if ((bullet.x < pos.x + zombieWalk[1].width*scale && bullet.x > pos.x) && (bullet.y < pos.y + zombieWalk[1].height*scale && bullet.y > pos.y)) {
          //if bullet hits zombie remove bullet from array
          playerProjectiles.remove(i);
          hit_zombie.play();
          deadMode = true;
          //vel.x = 0;
          updateScore();
          float r = random(0, 30);
          if (r <= 1.5) {
            Powerup p1 = new Powerup(pos);
            PowerupList.add(p1);
          }
          if (r <= 3 && r > 1.5){
            Shotgun s1 = new Shotgun(pos);
            ShotgunList.add(s1);
          }
          if(r >= 29){
           Heart h1 = new Heart(pos);
           HeartList.add(h1);
          }
          //early return to break out of loop
          return;
        }
      }
    }
  }
  
  void callDrops() {
    for (int p = 0; p < PowerupList.size(); p++) {  
      Powerup p1 = PowerupList.get(p);
      p1.spawn();
    }
  }
}
