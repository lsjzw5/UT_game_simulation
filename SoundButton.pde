class SoundButton {
  float x, y, r;
  boolean clicked;
  PShape soundOn = loadShape("soundon.svg");
  PShape soundOff = loadShape("soundoff.svg");

  SoundButton (float x, float y) {
    this.x = x;
    this.y = y;
    this.r = 60;
    this.clicked = false;
  }

  void clickEvent() {
    if ((mouseX < x + r/2 && mouseX > x) && (mouseY < y + r/2 && mouseY > y)) {
      this.mute();
      if (this.clicked == true) {
        this.clicked = false;
      } else {
        this.clicked = true;
      }
      display();
    }
  }

  void mute() {
    if (!pauseButton.clicked) {
      if (clicked) {
        background_mp3.loop();
      } else {
        background_mp3.pause();
      }
    }
  }

  void display() {
    pushStyle();
    noStroke();
    ellipseMode(CORNER);
    fill(255);
    ellipse(x, y, r/2, r/2);
    if (clicked == false) { 
      shape(soundOn, x, y, r/2, r/2);
    } else {
      shape(soundOff, x, y, r/2, r/2);
    }
    popStyle();
  }
}
