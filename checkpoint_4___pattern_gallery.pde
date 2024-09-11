color black = #000000;
color white = #ffffff;

int mode;
final int HOME  = 1;
final int XO    = 2;
final int WAVES = 3;
final int STARS = 4;

void setup() {
size(800, 600);
mode = HOME;

rectMode(CENTER);
textAlign(CENTER);
}

void draw() {
if (mode == HOME) {
    home();
  } else if (mode == XO) {
    xo();
  } else if (mode == WAVES) {
    waves();
  } else if (mode == STARS) {
    stars();
  } else {
    println("Mode error: " + mode);
  }
}
