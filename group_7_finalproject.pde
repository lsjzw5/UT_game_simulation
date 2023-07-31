//zombie variables
import processing.sound.*;
ArrayList<Zombie> ZombieList;
int lvl = 3;
float scale = .125;
int offset;
PImage zombieSize = new PImage();
Zombie z;
int a = 0;
PVector pos;
PVector vel;

//powerup variables
ArrayList<Powerup> PowerupList; 
PShape powerSize= new PShape();
ArrayList<Heart> HeartList;
Heart h;
ArrayList<Shotgun> ShotgunList;

//player varables
Player player;
ArrayList<Projectile> playerProjectiles;
int liveNum;
int scoreNum;
String lives;
String scores;
PVector player_pos;
WeaponHotbar hotbar;

//main menu animation objects
MManimation animation;
PImage mainBackground;
PFont titleFont;

//global button objects
PauseButton pauseButton;
MenuButton menuButton;
SettingsButton settingsButtonEasy;
SettingsButton settingsButtonMedium;
SettingsButton settingsButtonHard;
SettingsButton settingsButtonmain;
SettingsButton settingsButtonReset;
WinLoseButton main, restart;

//global game objects, variables, and states
String gameState;
boolean pauseGame;
boolean setupRun;
float scoreModifier;
float spawnModifier;
Timer spawnTimer;
Timer difficultyScalingTimer;
boolean isTimerSet;
PImage bg;

//import sound for processing
import processing.sound.*;
//sound variables
SoundButton soundButton;
SoundBar soundBar;
SoundFile background_mp3, firing_sound, hit_zombie;

void setup() {
  mainBackground = loadImage("images/menu.jpg");
  titleFont = createFont("PaintDropsRegular-0WaJo.ttf", 40);
  textFont(titleFont);
  //initialize sound variables
  soundButton = new SoundButton(width-35, 85);
  background_mp3 = new SoundFile(this, "Danny Baranowsky - $4cR1f1c14-_.mp3");
  firing_sound = new SoundFile(this, "firing.wav");
  hit_zombie = new SoundFile(this,"hit_zombie.mp3");
  background_mp3.loop();  
  soundBar = new SoundBar(width-25, 150, 15, 120, 0, 1);
  soundBar.currentPos = soundBar.y + (soundBar.h)/2;
  background_mp3.amp(soundBar.getVal()/25);

  //initialize button var
  main = new WinLoseButton("MAIN MENU", width/2-110, width/2-100, 140, 30);	
  restart = new WinLoseButton("RESTART", width/2+100, width/2-100, 140, 30);
  settingsButtonmain = new SettingsButton(width/2-50, (width/2) + 30, false, "Main Menu");
  settingsButtonReset = new SettingsButton(width/2+50, (width/2) + 30, false, "Reset");
  menuButton = new MenuButton(width/2, width/2, false);
  pauseButton = new PauseButton(width-35, 15);
  animation = new MManimation();
  //resetButton = new ResetButton(width-35, 50);

  //initalize game state var
  pauseGame = true;
  gameState = "Main Menu";
  isTimerSet = false;

  //initialize zombie, powerups, and player
  zombieSize = loadImage("images/Walk1.png");
  powerSize = loadShape("images/mac.svg");
  ZombieList = new ArrayList<Zombie>();
  PowerupList = new ArrayList<Powerup>();
  HeartList = new ArrayList<Heart>();
  ShotgunList = new ArrayList<Shotgun>();
  playerProjectiles = new ArrayList<Projectile>();
  hotbar = new WeaponHotbar(75,550);
  for (int i = 0; i < lvl; i++) {
   vel = new PVector(2, 2);
   pos = new PVector(random(0, (width-zombieSize.width*scale-20)), random(-zombieSize.height*scale, 0)); 
   offset = round(random(0, 6));
   Zombie z1 = new Zombie(pos, vel, scale, offset);
   ZombieList.add(z1);
  }
  player_pos = new PVector(width/2, width/2 + 80);
  player = new Player(player_pos.x, player_pos.y);

  //GUI variables in-game
  liveNum = 10;  
  scoreNum = 0;
  
  //required programming setup
  size(600, 600);
  textAlign(LEFT);
  textSize(24);
  bg = loadImage("images/route55.png");
  setupRun = false;
}

void draw() {
  //println(frameRate);
  //println("Game State: " + gameState);
  //player is in the main menu...
  float a = soundBar.getVal();
  if (gameState == "Main Menu"){
    
    image(mainBackground, -70, 0, 750, height);
    animation.display();
    pushStyle();
    textAlign(CENTER);
    textSize(70);
    fill(0);
    text("Zombie Survival", 300+3, 100+3);
    fill(#FA0808);
    text("Zombie Survival", 300, 100);
    
    textSize(36);
    fill(0);
    text("Choose your difficulty...", 300+2, 340+2);
    fill(#FA0808);
    text("Choose your difficulty...", 300, 340);
    popStyle();
    //checking if the initial setup for each button has been run
    if (setupRun == true){
      settingsButtonEasy.display();
      settingsButtonMedium.display();
      settingsButtonHard.display();
    }
    else{
      mainSetup(); //run setup function for main menu
    }
    soundButton.display();
    soundBar.update(mouseX,mouseY);
    if (!soundButton.clicked) {
      background_mp3.amp(soundBar.getVal()/25);
    }
    soundBar.display();
  }
  //player has selected a difficulty button
  if (gameState == "Easy" || gameState == "Medium" || gameState == "Hard"){

    //check if game is paused if it is display initial player and GUI
    if (pauseGame == true){
      
      image(bg, 0, 0, width, height);
      player.display();
      displayScore();
      displayLives();
      pauseButton.display();
      menuButton.display();
      menuButton.available = true;
      soundButton.display();
      soundBar.update(mouseX,mouseY);
      soundBar.display();
      if (!soundButton.clicked) {
        background_mp3.amp(soundBar.getVal()/25);
      }
      hotbar.display();
      //generate the timers
      setGameTimers();
    }
    //otherwise game is running
    else{
      image(bg, 0, 0, width, height);
      
      //spawn in zombies based on a timer
      if (spawnTimer.intervalPassed()){
        thread("spawn");
      }
      //if the scaling difficulty timer has passed alter the spawnTimer
      if (difficultyScalingTimer.intervalPassed()){
        //speed up the timer by 0.05 seconds
        spawnTimer.interval = spawnTimer.interval - 40;
        println("new spawn timer interval: " + spawnTimer.interval);
      }

      for (int x = 0; x < ZombieList.size(); x++) {
        z = ZombieList.get(x);
        z.bulletCollision();
        if(z.deadMode && z.vel.x < 0){
         z.rdead();
         }
        if(z.deadMode && z.vel.x > 0){
          z.dead();  
         }
        if (z.deadCount == 16) {
          ZombieList.remove(x);
        }
        if((z.pos.y + (.5*zombieSize.height*scale) >  player.pos.y - 27.5 && z.pos.y + (.5*zombieSize.height*scale) < player.pos.y + 27.5) && (z.pos.x + (.5*zombieSize.width*scale) > player.pos.x -15 && z.pos.x + (.5*zombieSize.width*scale) < player.pos.x+15)){
          if(z.attackMode == false){
             z.attackMode = true; 
          }
        }
          if(z.attackMode && z.vel.x < 0 && z.deadMode == false){
         z.rattack();
          }
          if(z.attackMode && z.vel.x > 0 && z.deadMode == false){
          z.attack();  
          }
          if (z.atkCount == 1){
            hit_zombie.amp(a/10);
            hit_zombie.play();
          }
          if (z.atkCount == 18) {
            ZombieList.remove(z);
            if(z.status == false){
              updateLives();
            }  
        }
        z.move();
      }
      for (int p = 0; p < PowerupList.size(); p++) {  
        Powerup p1 = PowerupList.get(p);
        p1.spawn();
        if(p1.powertime == 200){
         PowerupList.remove(p);
        }
      }
      for (int i = 0; i < HeartList.size(); i++) {  
        Heart h1 = HeartList.get(i);
        h1.spawn();
        if(h1.lifetime == 200){
         HeartList.remove(h1);
        }
      }
      for (int i = 0; i < ShotgunList.size(); i++) {  
        Shotgun s1 = ShotgunList.get(i);
        s1.spawn();
        if(s1.powertime == 200){
         ShotgunList.remove(s1);
        }
      }
      
      //update and display player and GUI variables
      player.update();
      player.display();
      pauseButton.display();
      displayScore();
      displayLives();
      //check number of lives, if it's 0 display lose screen
      if (liveNum == 0) {
        //before any display is made, add a overlay to let the user see the scores better
        pushStyle();
        rectMode(CORNER);
        fill(100,100,100,90);
        rect(0,0,width, height);
        popStyle();

        //variables to modify saved scores; there will be 2 columns and 10 rows
        String[][] scoreList = new String [2][10];
        //access scoreboard file 
        String[] lines = loadStrings("scoreboard.txt");
        //name for the player
        String name = "Player1";
        int newScore = scoreNum;
        //loop through lines and split based on name and score
        for (int i = 0; i < 10; i++){
          //split line into name and score
          String[] pieces = split(lines[i], " ");
          scoreList[0][i] = pieces[0];
          scoreList[1][i] = pieces[1];
          //check if score is higher or equal to the top score and perform replacement
          if (newScore >= int(scoreList[1][i])){
            //store name of old score and name
            String oldName =  scoreList[0][i];
            String oldScore = scoreList[1][i];
            //reassign array index
            scoreList [0][i] = name;
            scoreList [1][i] = str(newScore);
            //reasssign name for trickle effect down the leaderboard
            name = oldName;
            newScore = int(oldScore);
            println("After replacement score is: "+ scoreList[0][i] + " and the new name is: " + scoreList[1][i]);
          }
          //after any reassignment display the rank, name, and score on the screen
          pushStyle();
          textAlign(LEFT);
          textSize(20);
          //contrast text for easier visibility
          fill(0);
          text(i+1 + ".", 135-2, 300+1 + 22*(i));
          text(scoreList [0][i], 273-2, 300+1 + 22*(i));
          text(scoreList [1][i], 422-2, 300+1 + 22*(i));
          //dislay variables at 22px apart on each "row"
          fill(255);
          text(i+1 + ".", 135, 300 + 22*(i));
          text(scoreList [0][i], 273, 300 + 22*(i));
          text(scoreList [1][i], 422, 300 + 22*(i));
          popStyle();

        }
        //after list adjustment take array and reassign original full line list
        for (int i = 0; i < 10; i++){
          String [] joinArray = new String[2];
          joinArray[0] = scoreList[0][i];
          joinArray[1] = scoreList[1][i];
          String newLine = join(joinArray, " ");
          lines[i] = newLine;
        }
        //overwrite scoreboard file over old file
        saveStrings("scoreboard.txt", lines);
        //display lose screen text
        pushStyle();
        textAlign(CENTER);
        textSize(50);
        fill(0);
        text("YOU DIED!", width/2-2, (width/2)-160);
        fill(250, 0, 0);
        text("YOU DIED!", width/2, (width/2)-160);
        popStyle();
        
        pushStyle();
        textSize(20);
        fill(0);
        //display player score and high score
        text("Your Score: " + str(scoreNum), width/2-170-2, width/2-130);
        text("Highest score: " + scoreList [1][0], width/2+30-2, width/2-130);
        fill(#3CFF03);
        text("Your Score: " + str(scoreNum), width/2-170, width/2-130);
        text("Highest score: " + scoreList [1][0], width/2+30, width/2-130);
        popStyle();
        //display interactive buttons
        main.display();
        restart.display();

        //display leaderboard prompts
        pushStyle();
        textSize(20);
        textAlign(CENTER);
        fill(0);
        text("Leaderboard", 300-2,250);
        text("Rank", 150-2, 280);
        text("Name", 300-2, 280);
        text("Score", 450-2, 280);
        fill(#3CFF03);
        text("Leaderboard", 300,250);
        text("Rank", 150, 280);
        text("Name", 300, 280);
        text("Score", 450, 280);
        popStyle();

        noLoop();
      }
      soundButton.display();
      
      if (!soundButton.clicked) {
        background_mp3.amp(soundBar.getVal()/25);
      }
      hit_zombie.amp(a/10);
      firing_sound.amp(a/10);
      soundBar.update(mouseX,mouseY);
      soundBar.display();
      hotbar.display();
    }
  }

  
}
//function to check the user's key input
void keyPressed() {
  //movement key presses
  if ((key == 'w' || key == 'a' || key == 's' || key == 'd') || (key == 'W' || key == 'A' || key == 'S' || key == 'D') ) {
    player.movePress();
  }
  //projectile key presses
  if (key == CODED && (keyCode == LEFT || keyCode == RIGHT || keyCode == UP || keyCode == DOWN)) {
    player.firePress();
    player.fireProjectile();
  }  
  
}
void keyReleased() {
  //movement key released
  if ((key == 'w' || key == 'a' || key == 's' || key == 'd') || (key == 'W' || key == 'A' || key == 'S' || key == 'D') ) {
    player.moveRelease();
  }
  //projectile key released
  if (key == CODED && (keyCode == LEFT || keyCode == RIGHT || keyCode == UP || keyCode == DOWN)) {
    player.fireRelease();
    //firing_sound.stop();
  }
  //user input for hotbar to change weapon
  if (key == ' '){
    hotbar.keyreleaseEvent();
  }
  if (key == '1'){
    hotbar.changeSelection(1);
  }
  if (key == '2'){
    hotbar.changeSelection(2);
  }
  if (key == '3'){
    hotbar.changeSelection(3);
  }
}
//function to check if the user has clicked a button
void mouseClicked() {
  pauseButton.clickEvent();
  menuButton.clickEvent();
  settingsButtonEasy.clickEvent();
  settingsButtonMedium.clickEvent();
  settingsButtonHard.clickEvent();
  settingsButtonmain.clickEvent();
  settingsButtonReset.clickEvent();
  soundButton.clickEvent();
  restart.clickEvent();
  main.clickEvent();
}
void mousePressed() {
  soundBar.pressed(mouseX, mouseY);
}
void mouseReleased() {
  soundBar.released();
}

//function to display the lives of the player in the UI
void displayLives() {
  pushStyle();
  fill(#3CFF03);
  lives = "Lives: " + str(liveNum);
  text(lives, 5, 90);
  popStyle();
}
//function to remove a life if the are hit
void updateLives() {
  if (liveNum>0) {
    liveNum -= 1;
  }
}
//function to display the score of the player in the UI
void displayScore() {
  scores = "Score: " + str(scoreNum);
  pushStyle();
  fill(#3CFF03);
  text(scores, 5, 25);
  popStyle();
}
//function to add to the score of the player based on a flat modifier
void updateScore() {
  scoreNum += 10 * scoreModifier;
}
//function to create user buttons to choose their difficulty
void mainSetup(){
  settingsButtonEasy = new SettingsButton(width/2 - 100, 380, false, "Easy");
  settingsButtonEasy.visible = true;
  settingsButtonEasy.available = true;
  settingsButtonMedium = new SettingsButton(width/2, 380, false, "Medium");
  settingsButtonMedium.visible = true;
  settingsButtonMedium.available = true;
  settingsButtonHard = new SettingsButton(width/2 + 100, 380, false, "Hard");
  settingsButtonHard.visible = true;
  settingsButtonHard.available = true;
  setupRun = true;
  
}
//function to create first frame of the level and timers upon difficulty selection
void setGameTimers(){
  //if timers have been made then return
  if (isTimerSet == true){return;}
  //generate the timer
  else{
    //base spawn rate is 1 zombie per 1.5 seconds
    spawnTimer = new Timer(int(1500/spawnModifier), millis());
    spawnTimer.pauseTimer();
    //every 10 seconds the spawn timer will have its current value increased
    difficultyScalingTimer = new Timer(10000, millis());
    difficultyScalingTimer.pauseTimer();
    //show that timers have been set
    isTimerSet = true;
  }
}
//function that will emulate the setup function to reset variables and game
void resetGame() {
  //soundButton = new SoundButton(width-35, 85);
  //soundBar.currentPos = soundBar.y + (soundBar.h)/2;
  soundBar.display(); 
  //soundButton.clicked = !soundButton.clicked;
  soundButton.display();
  //background_mp3.amp(soundBar.getVal());
  //background_mp3.loop();
  PVector pos = new PVector(500, 0);
  PVector vel = new PVector(0, 0.33);
  ZombieList = new ArrayList<Zombie>();
  PowerupList = new ArrayList<Powerup>();
  ShotgunList = new ArrayList<Shotgun>();
  hotbar = new WeaponHotbar(75,550);
  for (int i = 0; i < lvl; i++) {
   if (lvl > 3) {
     vel = new PVector(random(-.7, .7), 0.33);
   }
   pos = new PVector(random(0, (width-zombieSize.width*scale-20)), random(3*-zombieSize.height*scale, -zombieSize.height*scale)); 
   offset = round(random(0, 6));
   Zombie z1 = new Zombie(pos, vel, scale, offset);
   ZombieList.add(z1);
  }
  playerProjectiles = new ArrayList<Projectile>();
  player = new Player(player_pos.x, player_pos.y);
  //start frame overlay so when the game is "paused" they can see the player at the start
  image(bg, 0, 0, width, height);
  pauseButton.display();
  menuButton.display();
  player.update();
  player.display();
  scoreNum = 0;
  liveNum = 10;
  displayScore();
  displayLives();
  menuButton.clicked = false;
  menuButton.display();
  menuButton.available = true;
  pauseButton.display();
  hotbar.display();
  isTimerSet = false;
  pauseGame = true;
}

void spawn(){
   float r = random(1,4);
   if(r <= 1){
   pos = new PVector(random(-zombieSize.width*scale, (width+zombieSize.width*scale)), random(-zombieSize.height*scale, 0));
   }
   if(r <= 2 && r > 1){
   pos = new PVector(random(-zombieSize.width*scale, 0), random(-zombieSize.height*scale, height));
   }
   if(r <= 3 && r > 2){
   pos = new PVector(random(width, width+zombieSize.width*scale), random(-zombieSize.height*scale, height));
   }
   if(r <= 4 && r > 3){
   pos = new PVector(random(-zombieSize.width*scale, (width+zombieSize.width*scale)), random(height, height + zombieSize.height*scale));
   }
   vel = new PVector(2, 2);
   Zombie baby = new Zombie(pos, vel, scale, offset);
   ZombieList.add(baby);
}
