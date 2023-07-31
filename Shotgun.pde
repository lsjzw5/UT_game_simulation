class Shotgun {
  PShape sg;
  boolean exist;
  PVector pos;
  int powertime;
  
  Shotgun(PVector pos) {
    this.pos = pos;
    sg = loadShape("images/shotgun.svg");
  }

  void spawn() {
    shape(sg, pos.x, pos.y, 40, 40);
    powertime += 1;
  }
}
