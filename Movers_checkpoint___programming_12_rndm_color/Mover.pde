class Mover {

  //instance variables
  float x, y, c, c2, c3;

  //constructor
  Mover() {
    x = width/2;
    y = height/2;
    c = random(0, 255);
    c2 = random(0, 255);
    c3 = random(0, 255);
  }

  void show() {
    stroke(0);
    fill(c, c2, c3);
    strokeWeight(5);
    circle(x, y, 100);
  }

  void act() {
    x = x + random(-4, 4);
    y = y + random(-4, 4);
  }
}
