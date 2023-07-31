class WinLoseButton {
  String function;
  float x, y, w, h;

  WinLoseButton(String _function, float _x, float _y, float _w, float _h) {
    function = _function;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }

  void display() {
    pushStyle();
    textAlign(CENTER);
    rectMode(CENTER);
    strokeWeight(3);
    stroke(250);
    fill(20);
    rect(x, y, w, h);
    fill(250);
    textSize(20);
    text(function, x+0.5, y+7);
    popStyle();
  }

  boolean isOver() {
    float dx = mouseX;
    float dy = mouseY;
    if (dx > x-w/2 && dx < x+w/2 && dy > y-h/2 && dy < y+h/2) {
      return true;
    }
    return false;
  }

  void clickEvent() {
    if (function == "RESTART") {
      if (isOver() && !pauseButton.clicked) {
        resetGame();       
        loop();
      }
    } else if (function == "MAIN MENU") {
      if (isOver() && !pauseButton.clicked) {
        gameState = "Main Menu";
        resetGame();
        loop();
      }
    }
  }
}
