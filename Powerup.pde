class Powerup {
  PShape submac;
  boolean exist;
  PVector ps;
  int powertime;
  
  Powerup(PVector pos) {
    this.ps = pos;
    submac = loadShape("images/mac.svg");
  }

  void spawn() {
    shape(submac, ps.x, ps.y, 36, 36);
    powertime += 1;
  }
}
