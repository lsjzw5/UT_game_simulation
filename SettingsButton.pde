class SettingsButton {
  float x, y;
  float r;
  boolean clicked;
  String stateChange;
  int textSize;
  boolean available;
  boolean visible;

  SettingsButton(float _x, float _y, boolean click, String _stateChange) {
    this.x = _x;
    this.y = _y;
    //default parameters that cannot be accessed by the user
    this.r = 75;
    this.clicked = click;
    this.stateChange = _stateChange;
    this.textSize = 18;
    available = false;
    visible = false;
  }
  //event observer 
  void clickEvent() {
    if ((mouseX < x + r/2 && mouseX > x - r/2) && (mouseY < y + r/2 && mouseY > y - r/2)&& available == true) {
      if (visible){
        this.changeScreen();
        clicked = true;
      }
      
    }
  }
  //event function
  void changeScreen() {
    
    //if the setting button is main menu
    if (stateChange == "Main Menu"){
      println("main menu button was clicked, game state is: " + gameState);
      gameState = stateChange;
      visible = false;
      available = false;
      //call reset function for level
      resetGame();
      pauseGame = true;
      //loop draw call again as it might have been from the pause button
      loop();
      menuButton.clicked = false;
    }

    //dont change the state of the game, just reset! 
    if (stateChange == "Reset"){
      visible = false;
      available = false;
      //call reset function for level
      resetGame();
      pauseGame = true;
      //loop draw call again as it might have been from the pause button
      loop();
      menuButton.clicked = false;
    }

    
    if (stateChange == "Easy"){
      gameState = stateChange;
      spawnModifier = 1.0;
      scoreModifier = 1.0;
    }
    if (stateChange == "Medium"){
      gameState = stateChange;
      spawnModifier = 1.5;
      scoreModifier = 1.5;
    }
    if (stateChange == "Hard"){
      gameState = stateChange;
      spawnModifier = 2.0;
      scoreModifier = 2.0;
    }
  }

  //default display 
  void display() {
    if (visible == true) {
      pushStyle();
      rectMode(CENTER);
      textSize(textSize);
      if (stateChange == "Easy"){
        fill(#5AC44D);
      }
      if (stateChange == "Medium"){
        fill(#FC992E);
      }
      if (stateChange == "Hard"){
        fill(#E82828);
      }
      if (stateChange == "Main Menu" || stateChange == "Reset"){
        fill(155);
        textSize(15);
      }
      rect(x, y, r, r/2, 8);
      
      textAlign(CENTER);
      fill(0);
      text(stateChange, x-1, y+6);
      fill(255);
      text(stateChange, x, y+5);
      popStyle();
    }
  }
}
