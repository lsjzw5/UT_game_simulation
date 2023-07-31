class SoundBar {
  int x, y;
  float w, h;
  float currentPos;
  float minPos, maxPos;
  boolean isMouseOver;
  boolean isLocked;
  float minVal, maxVal;
  
  SoundBar(int _x, int _y, float _w, float _h, float _minVal, float _maxVal) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    minVal = _minVal;
    maxVal = _maxVal;
    currentPos = y;
    minPos = y;
    maxPos = y+h;
  }
  
  boolean isOver(int mx, int my) {
    return (mx > x && mx < x+w && my > y && my < y+h);
  }
  
  void update(int mx, int my) {
    isMouseOver = isOver(mx, my);
    if (isLocked) {
      currentPos = constrain(my-(w/2), minPos, maxPos);
    }
  }
  
  float getVal() {
    float t = (currentPos - minPos)/(maxPos - minPos);
    if (soundButton.clicked) {
      return 0;
    }
    return maxVal*(1 - t) + minVal*t;
  }
  
  void released() { 
    isLocked = false;
  }
  
  void display() {
    pushStyle();
    textAlign(CENTER);
    fill(0);
    textSize(14);
    text("Sound", x+7,y-10);
    text("Lvl:", x+10,y);
    popStyle();
    pushStyle();
    fill(255);
    rectMode(CORNER);
    rect(x, y, w, w+h);
    if (isMouseOver) {
      fill(0);
    } else {
      fill(102);
    }
    rect(x, currentPos, w, w);
    popStyle();
  }
  
  void pressed(int mx, int my) {
    if (isMouseOver) {
      isLocked = true;
    } else {
      isLocked = false;
    }
  }
  
}
