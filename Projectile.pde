class Projectile {
  //positonal paramenters
  float x, y;
  float diameter;
  float radius;
  //direction and speed varaibles
  PVector velocity;
  float theta;

  Projectile(float _x, float _y, float len, float angle) {
    x = _x;
    y = _y;
    diameter = len;
    radius = len/2;
    theta = angle;
    velocity = new PVector(0,0);
    //check which direction the projectile has been fired -- max velocity of the bullet is 6 pixels in a direction
    velocity.x = 6*cos((theta) * (PI/180));
    velocity.y = 6*sin((theta) * (PI/180));
  }

  //basic display function of the projectile and its "shadow"
  void display() {
    pushStyle();
    rectMode(CENTER);
    stroke(#FA9C05);
    fill(#FFDA08);
    rect(x, y, radius, radius);
    noStroke();
    fill(color(0, 0, 0, 95));
    rect(x+3, y+10, radius, radius);
    popStyle();
  }

  //function that returns a boolean if projectile is fully off the screen
  boolean isOffScreen() {
    if (y-radius < 0 || y+radius > height || x-radius < 0 || x-radius > width) {
      return true;
    } else {
      return false;
    }
  }

  //function to move the bullet in a linear line at a fixed velocity
  void move() {
    x += velocity.x;
    y += velocity.y;
  }
}
