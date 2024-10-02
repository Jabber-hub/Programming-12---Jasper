class Mover {

  //instance variables
  float x, y, d;

  //constructor
  Mover() {
    x = width/2;
    y = height/2;
    d = random(50, 100);
  }

  void show() {
    stroke(0);
    fill(255);
    strokeWeight(5);
    circle(x, y, d);
  }

  void act() {
    x = x + random(-2, 2);
    y = y + random(-2, 2);
  }
}
