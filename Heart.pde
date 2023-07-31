class Heart{
  PShape heart;
  PVector pos;
  int lifetime;
  
  Heart(PVector pos) {
    this.pos = pos;
    heart = loadShape("images/heart.svg");
  }

  void spawn() {
    shape(heart, pos.x, pos.y, 36, 36);
    lifetime += 1;
  }
}
