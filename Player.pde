class Player {
  //positional variables
  PVector pos;
  PVector velocity;
  PVector tempVel;
  float h, w;
  //boolean variables to evaluate player states
  boolean left, right, up, down;
  boolean shooting, s_up, s_down, s_left, s_right;
  boolean powerUpEnabled;
  boolean powerUpUsed;
  //player gun variables
  float fireRate = 1.4; //projectiles per second
  Timer gunTimer = new Timer(int(1000/fireRate), millis()); //timer matching gun fire rate
  int weaponSelection = 1;
  Timer powerTimer = new Timer(6000, millis());
  int smgAmmo;
  int shotgunAmmo;
  //player display variables
  Timer animationTimer = new Timer(1000/5, millis()); //animations will be 3 frames per second
  int numFrames = 4;
  int currentFrame;
  PImage[] playerWalkN;
  PImage[] playerWalkS;
  PImage[] playerWalkE;
  PImage[] playerWalkW;
  String inputDirection;

  Player(float _x, float _y) {
    playerWalkN = new PImage[numFrames];
    playerWalkS = new PImage[numFrames];
    playerWalkE = new PImage[numFrames];
    playerWalkW = new PImage[numFrames];
    //loop through and add all sprite images to arrays
    for (int i = 0; i < playerWalkN.length; i++) {
      String imgN= "images/cops/walk_N/walk0" + nf(i+1) + ".png";
      playerWalkN[i] = loadImage(imgN);
      
      String imgS= "images/cops/walk_S/walk0" + nf(i+1) + ".png";
      playerWalkS[i] = loadImage(imgS);
      
      String imgE= "images/cops/walk_E/walk0" + nf(i+1) + ".png";
      playerWalkE[i] = loadImage(imgE);
      
      String imgW= "images/cops/walk_W/walk0" + nf(i+1) + ".png";
      playerWalkW[i] = loadImage(imgW);
      
    }
    //starting ammo of the character when initialized should be zero
    smgAmmo = 0;
    shotgunAmmo = 0;

    //new position variables
    pos = new PVector(_x,_y);
    velocity = new PVector(0,0);
    tempVel = new PVector(0,0);
    w = 24;
    h = 45;
    left = false;
    right = false;
    up = false;
    down = false;
    shooting = false;
    s_up = false; 
    s_down = false;
    s_left = false;
    s_right = false;
    powerUpEnabled = false;
    powerUpUsed = false;
    currentFrame = 0;
    inputDirection = "up";  //player starts facing upwards
  }
  //function that will alter the booleans from the proper key press
  void movePress() {
    if (key == 'a' || key == 'A') {
      left = true;
    }
    if (key == 'w' || key == 'W') {
      up = true;
    }
    if (key == 's' || key == 'S') {
      down = true;
    }
    if (key == 'd' || key == 'D') {
      right = true;
    }
   
  }

  //function that will alter directional booleans to false with the release of the proper key
  void moveRelease() {
    if (key == 'a' || key == 'A') {
      left = false;
    }
    if (key == 'w' || key == 'W') {
      up = false;
    }
    if (key == 's' || key == 'S') {
      down = false;
    }
    if (key == 'd' || key == 'D') {
      right = false;
    }
  }

  //function to alter the booleans to get the proper projectile direction when they are created
  void firePress() {
    if (keyCode == LEFT) {
      s_up = false;
      s_down = false;
      s_left = true;
      s_right = false;
      inputDirection = "left";
    }
    if (keyCode == RIGHT) {
      s_up = false;
      s_down = false;
      s_left = false;
      s_right = true;
      inputDirection = "right";
    }
    if (keyCode == UP) {
      s_up = true;
      s_down = false;
      s_left = false;
      s_right = false;
      inputDirection = "up";
    }
    if (keyCode == DOWN) {
      s_up = false;
      s_down = true;
      s_left = false;
      s_right = false;
      inputDirection = "down";
    }
    //added in a variable to show that a firing button is being pressed
    shooting = true;
    
  }
  //function to change boolean of the direction that is released to stop shooting
  void fireRelease() {
    if (keyCode == LEFT) {s_left = false;}
    if (keyCode == UP) {s_up = false;}
    if (keyCode == DOWN) {s_down = false;}
    if (keyCode == RIGHT) {s_right = false;}
    //if all directions are false after this then stop shooting;
    if (s_left == false && s_right == false && s_down == false && s_up == false){
      shooting = false;
    }
    
  }
  
  //function to update the different functions observing the player's inputs at each draw call
  void update() {
    //move player
    move();
    //update frame of the player if timer has ellapsed
    if (animationTimer.intervalPassed() == true){
      currentFrame = (currentFrame + 1) % numFrames;
    }
    //check if player is over each of the different powerups
    overHeart();
    overPowerUp();
    overShotgun();

    //fire projectile in case keyboard is not able to detect multiple held keys
    fireProjectile();
    //update all projectiles
    projectileUpdate();
  }

  //function that ties the player's weapon state with the hotbar changes
  void changeWeapon(int hotbarNum){
    //if the pistol is selected
    if (hotbarNum == 1){
      weaponSelection = 1;
      fireRate = 1.4;
      gunTimer = new Timer(int(1000/fireRate), millis());
    }
    //if the sub-machine gun is selected
    if (hotbarNum == 2){
      weaponSelection = 2;
      fireRate = 10;
      gunTimer = new Timer(int(1000/fireRate), millis());
    }
    //if the shotgun is selected
    if (hotbarNum == 3){
      weaponSelection = 3;
      fireRate = 2;
      gunTimer = new Timer(int(1000/fireRate), millis());
    }

  }
  //function to update the entire projectile array to check for bullets going off of the screen
  void projectileUpdate() {
    for (int i = playerProjectiles.size() - 1; i >= 0; i--) {
      Projectile bullet = playerProjectiles.get(i);
      //if bullet is off screen then remove from array
      if (bullet.isOffScreen() == true) {
        playerProjectiles.remove(i);
      }
      else{
        bullet.move();
      }
    }
  }


  private void shotgunProjectile(int proj_num){
    for (int i = 0; i < proj_num; i++){
    
      }
  }

  void fireProjectile() {
    //if the user is holding a arrow key and the player is able to shoot
    if (shooting == true && gunTimer.intervalPassed()) {
      
      //check which gun type is being used
      //pistol will always fire...
      if (weaponSelection == 1){
        //check which direction projectile is being fired
        if (s_up == true){
          playerProjectiles.add(new Projectile(pos.x, pos.y-h/2, 10, 270));
        }
        else if(s_down == true){
          playerProjectiles.add(new Projectile(pos.x-6, pos.y+18, 10, 90));
        }
        else if(s_left == true){
          playerProjectiles.add(new Projectile(pos.x - w/2, pos.y+10, 10, 180));
        }
        else{
          playerProjectiles.add(new Projectile(pos.x + w/2, pos.y+10, 10, 0));
        }
        firing_sound.play();
      }
      //player is shooting the SMG
      if (weaponSelection == 2 && smgAmmo > 0){
        //check which direction projectile is being fired
        if (s_up == true){
          playerProjectiles.add(new Projectile(pos.x, pos.y-h/2, 10, 270));
        }
        else if(s_down == true){
          playerProjectiles.add(new Projectile(pos.x-6, pos.y+18, 10, 90));
        }
        else if(s_left == true){
          playerProjectiles.add(new Projectile(pos.x - w/2, pos.y+10, 10, 180));
        }
        else{
          playerProjectiles.add(new Projectile(pos.x + w/2, pos.y+10, 10, 0));
        }
        firing_sound.play();
        //remove one of the ammo from the hotbar and the player variable
        hotbar.SMGBox.ammoCount -= 1;
        smgAmmo -= 1;
      }
      //player is shooting the shotgun
      if (weaponSelection == 3 && shotgunAmmo > 0){
        //check which direction projectile is being fired (each "burst" will have 3 bullets)
        if (s_up == true){
          playerProjectiles.add(new Projectile(pos.x, pos.y-h/2, 10, 280));
          playerProjectiles.add(new Projectile(pos.x, pos.y-h/2, 10, 270));
          playerProjectiles.add(new Projectile(pos.x, pos.y-h/2, 10, 260));
        }
        else if(s_down == true){
          playerProjectiles.add(new Projectile(pos.x-6, pos.y+18, 10, 100));
          playerProjectiles.add(new Projectile(pos.x-6, pos.y+18, 10, 90));
          playerProjectiles.add(new Projectile(pos.x-6, pos.y+18, 10, 80));
        }
        else if(s_left == true){
          playerProjectiles.add(new Projectile(pos.x - w/2, pos.y+10, 10, 190));
          playerProjectiles.add(new Projectile(pos.x - w/2, pos.y+10, 10, 180));
          playerProjectiles.add(new Projectile(pos.x - w/2, pos.y+10, 10, 170));

        }
        else{
          playerProjectiles.add(new Projectile(pos.x + w/2, pos.y+10, 10, 10));
          playerProjectiles.add(new Projectile(pos.x + w/2, pos.y+10, 10, 0));
          playerProjectiles.add(new Projectile(pos.x + w/2, pos.y+10, 10, -10));
        }
        firing_sound.play();
        //remove one of the ammo from the hotbar and the player variable
        hotbar.shotgunBox.ammoCount -= 1;
        shotgunAmmo -= 1;
      }
      
    }
  }
  //function to access the display function of the projectile
  void displayProjectile(){
    for (int i = playerProjectiles.size() - 1; i >= 0; i--) {
      Projectile bullet = playerProjectiles.get(i);
      bullet.display();
    }
  }
  
  //function to check if the player is over any heart powerups
  void overHeart(){
    for (int i = 0; i < HeartList.size(); i++) {  
      Heart theHeart = HeartList.get(i);
      if ((((pos.x + w/2) < theHeart.pos.x + 36) && ((pos.x + w/2) > theHeart.pos.x)) && ((pos.y + h/2) < theHeart.pos.y + 36) && ((pos.y + h/2) > theHeart.pos.y)){
        HeartList.remove(i);
        liveNum += 1;
      }
    }
  }  
  //function to check if the player is over any SMG powerups
  void overPowerUp() {
    for (int i = 0; i < PowerupList.size(); i++) {
      Powerup powerup = PowerupList.get(i);
      if ((((pos.x + w/2) < powerup.ps.x + 36) && ((pos.x + w/2) > powerup.ps.x)) && ((pos.y + h/2) < powerup.ps.y + 36) && ((pos.y + h/2) > powerup.ps.y)) {
        //add ammo to SMG ammo count
        hotbar.SMGBox.ammoCount += 30;
        smgAmmo += 30;
        PowerupList.remove(i);
        powerUpEnabled = true;
        powerUpUsed = false;
        if(fireRate == 1.4){
        powerTimer.paused = true;
        }
      }
    }
  }
  //function to check if the player is over any shotgun powerups
  void overShotgun(){
    for (int i = 0; i < ShotgunList.size(); i++) {
      Shotgun shotgun = ShotgunList.get(i);
      if ((((pos.x + w/2) < shotgun.pos.x + 40) && ((pos.x + w/2) > shotgun.pos.x)) && ((pos.y + h/2) < shotgun.pos.y + 40) && ((pos.y + h/2) > shotgun.pos.y)) {
        hotbar.shotgunBox.ammoCount += 8;
        shotgunAmmo +=8;
        ShotgunList.remove(i);
        powerUpEnabled = true;
        powerUpUsed = false;
        if(fireRate == 1.4){
        powerTimer.paused = true;
        }
      }
    }
  }

  //display function that takes into account the direction that the player is facing
  void display() {
    pushStyle();
    fill(#ffffff);
    noStroke();
    //rect(pos.x,pos.y,w,h); //var to see hitbox of player
    popStyle();
    //depending on which way the player is facing use the correct array
    if(inputDirection == "up"){
      image(playerWalkN[currentFrame], pos.x-w/2, pos.y-h/2, w, h);
    }
    else if(inputDirection == "down"){
      image(playerWalkS[currentFrame], pos.x-w/2, pos.y-h/2, w, h);
    }
    else if(inputDirection == "left"){
      image(playerWalkW[currentFrame], pos.x-w/2, pos.y-h/2, w, h);
    }
    else{
      image(playerWalkE[currentFrame], pos.x-w/2, pos.y-h/2, w, h);
    }

    //call function to display player projectiles
    displayProjectile();
  }
  
  //function called if the user pressed A, D, or arrow keys
  void move() {
    //reset temp vector
    tempVel = new PVector(0,0);
    //sum all imput movements
    if (left == true) { tempVel.x -= 3;}
    if (right == true) { tempVel.x += 3;}
    if (up == true) { tempVel.y -= 3;}
    if (down == true) { tempVel.y += 3;}

    //if user is going in two directions modify velocity
    if (tempVel.x != 0 && tempVel.y != 0){
      //calculate hypotenuse velocity of direction 
      float hyp = sqrt((sq(tempVel.x) + sq(tempVel.y)))/2;
      //replace directions with modified values
      tempVel.x = tempVel.x / abs(tempVel.x); //turn velocity vectors into unit vectors then scale by modifier
      tempVel.y = tempVel.y / abs(tempVel.y);
      tempVel.x = tempVel.x * hyp;
      tempVel.y = tempVel.y * hyp;
    }

    //replace current velocity with an interpolation between new and old velocity
    velocity.x = lerp(velocity.x, tempVel.x, 0.3); //30% change in velocity towards new velocity
    velocity.y = lerp(velocity.y, tempVel.y, 0.3);

    //apply velocity of character to position vector
    //if position is not off screen boundaries then apply vector
    if ((pos.x + velocity.x > w/2) && (pos.x + velocity.x < width - w/2)){
      pos.x += velocity.x;
    }

    if ((pos.y + velocity.y > h/2) && (pos.y + velocity.y < height - h/2)){
      pos.y += velocity.y;
    }
  }
}
