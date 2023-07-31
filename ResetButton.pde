class ResetButton {
  PShape reset;
  float x, y, w, h;
  float r;
  color buttonColor;

  ResetButton(float x, float y) {
    this.x = x;
    this.y = y;
    this.r = 60;
  }

  void display() {
    reset = loadShape("images/reset.svg");
    pushStyle();
    fill(250);
    noStroke();
    ellipseMode(CORNER);
    ellipse(x, y, r/2, r/2);
    shape(reset, x, y, r/2, r/2);
    popStyle();
  }

  boolean overButton() {
    float dx = mouseX;
    float dy = mouseY;
    if (dx > x && dx < x+w && dy > y && dy < y+h) {
      return true;
    }
    return false;
  }

  void clickEvent() {
    if (mouseX < x+r/2 && mouseX > x && mouseY < y+r/2 && mouseY > y) {
      if (menuButton.clicked == false || pauseButton.clicked == true) {
        return;
      } else {
        this.reset();
      }
    }
  }

  void reset() {
    resetGame();
    scoreNum = 0;
    scores = "Score: " + str(scoreNum);
  }
}
