color black = #000000;
color white = #ffffff;
color gold  = #bf9a33;
color ocean = #005477;

int sx;
int sy;
int xx;
int xy;
int wx;
int wy;
int mode;
final int HOME  = 1;
final int XO    = 2;
final int WAVES = 3;
final int STARS = 4;

void setup() {
size(800, 600);
mode = HOME;
sx = 35;
sy = 35;

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
