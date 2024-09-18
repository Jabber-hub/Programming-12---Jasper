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
boolean dragging = false;

void setup() {
  size(600, 800);
  mode = MAP1;
  x = 300;
  y = 600;
  d = 55;
  vx = 0;
  vy = 0;

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
  //if (dragging) text("dragging", width/2, height/2);
  //if (!dragging) text("not dragging", width/2, height/2);
}



void mousePressed() {
  if (dist(mouseX, mouseY, x, y) < 35) {
    dragging = true;
  }
}

void mouseReleased() {
  if (dragging == true && mouseX < 500 && mouseX > 100 && mouseY > 500) {
    vx = (x - mouseX)/12;
    vy = (y - mouseY)/12;
    dragging = false;
  }
}
