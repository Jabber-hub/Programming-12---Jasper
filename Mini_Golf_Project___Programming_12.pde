color green  = #4DB71A;
color white  = #ffffff;
color black  = #000000;
color blue   = #98B1C6;
color orange = #E39732;

//mode
int mode;
final int MAP1     = 1;
final int MAP2     = 2;
final int MAP3     = 3;
final int GAMEOVER = 4;

//ball variables
float x, y, vx, vy;
int d;

void setup() {
  size(600, 800);
  mode = MAP3;
  x = 300;
  y = 600;
  d = 55;
  vx = -4;
  vy = -5;
  
  rectMode(CENTER);
}

void draw() {
  if (mode == MAP1) {
    map1();
  } else if (mode == MAP2) {
    map2();
  } else if (mode == MAP3) {
    map3();
  } else if (mode == GAMEOVER) {
    gameover();
  } else {
    println("Error: Mode = " + mode);
  }
}
