class MenuButton {
  float x, y;
  float r;
  boolean clicked;
  boolean available;

  //inializer function
  MenuButton(float _x, float _y, boolean click) {
    this.x = _x;
    this.y = _y;
    //default parameters that cannot be accessed by the user
    this.r = 50;
    this.clicked = click;

  }
  //event observer 
  void clickEvent() {
    //check if the button is available to be clicked
    if (available == false){
      return;
    }
    //check if the user has clicked the button in its display
    else if ((mouseX < x + r/2 && mouseX > x - r/2) && (mouseY < y + r/2 && mouseY > y - r/2)&& clicked == false) {
      //if it is clicked, then call unpause function
      this.Unpause();
      clicked = true;
      available = false;
    }
  }
  //event function to change the game state from being paused
  void Unpause() {
    pauseGame = false;
    //start the spawn timers!!
    spawnTimer.pauseTimer();
    difficultyScalingTimer.pauseTimer();
  }

  //default display 
  void display() {
    if (clicked == false) {
      pushStyle();
      rectMode(CENTER);
      fill(100, 100, 100, 200);
      rect(x, y, 50, 50, 10);
      fill(255);
      triangle(x-15, y-15, x+15, y, x-15, y+15);
    }
  }
}
