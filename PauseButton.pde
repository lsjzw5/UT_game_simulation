class PauseButton {
  //container shape
  float x, y;
  float r;
  boolean clicked;
  PShape pause = loadShape("images/pause.svg");
  PShape play = loadShape("images/resume.svg");

  //initialize function
  PauseButton (float x, float y) {
    this.x = x;
    this.y = y;
    //default parameters that cannot be accessed by the user
    this.r = 60;
    this.clicked = false;
  }

  //event observer 
  void clickEvent() {
    //if the start button has not been clicked then clicking it will do nothing
    if (menuButton.clicked == false) {
      return;
    } else {
      if ((mouseX < x + r/2 && mouseX > x) && (mouseY < y + r/2 && mouseY > y)) {
        this.pause();
      }
    }
  }

  //event function
  void pause() {
    //if pause button is clicked display menu button
    if (clicked) {
      loop();
      settingsButtonmain.visible = false;
      settingsButtonmain.available = false;
      this.clicked = false;
    //draw single frame of pause menu objects
    } else {
      noLoop();
      pushStyle();
      noStroke();
      rectMode(CORNER);
      ellipseMode(CORNER);
      textAlign(CENTER);
      //overlay rectangle
      fill(100, 100, 100, 80);
      rect(0, 0, width, height);
      fill(255);
      ellipse(x, y, r/2, r/2);
      shape(play, x, y, r/2, r/2);
      //change the clicked state to be true
      this.clicked = true;
      textSize(60);
      fill(0);
      //UI text to show that the game is paused
      text("Pause", width/2, width/2 - 30);
      fill(#3CFF03);
      text("Pause", width/2, width/2  - 33);
      //display the hidden main menu button to the user and make it clickable
      settingsButtonmain.visible = true;
      settingsButtonmain.available = true;
      settingsButtonmain.display();
      settingsButtonReset.visible = true;
      settingsButtonReset.available = true;
      settingsButtonReset.display();
      menuButton.display();
      popStyle();
      
    }
  }
  //default display when not paused
  void display() {
    pushStyle();
    noStroke();
    ellipseMode(CORNER);
    fill(255);
    ellipse(x, y, r/2, r/2);
    shape(pause, x, y, r/2, r/2);
    popStyle();
  }
}
