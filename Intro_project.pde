//Jasper
//Programming 12 intro project
//Sept 5

void setup() {
  size(800, 600);
}

void draw() {
  background(#BFD0FF);
  house();
  sun(200, 100);
}

void house() {
  //Grass
  fill(#21B714);
  rect(0, 500, 800, 100);
  //house walls
  fill(#FFFFFF);
  rect(400, 300, 250, 200);
  //windows
  fill(#CEF6FF);
  circle(450, 350, 60);
  square(570, 325, 50);
  //door
  fill(#000000);
  rect(500, 400, 50, 100, 25, 25, 0, 0);
  //chimney
  rect(570, 200, 50, 100);
  //Roof
  fill(#C96431);
  triangle(350, 300, 525, 200, 700, 300);
}

void sun(int x, float y) {
  fill(#EDBF02);
  line(150, y, 125, y);
  line(250, y, 275, y);
  line(200, y+50, 200, y+75);
  line(200, y-50, 200, y-75);
  line(225, y+25, 275, y+75);
  line(175, y-25, 125, y-75);
  line(225, y-25, 275, y-75);
  line(175, y+25, 125, y+75);
  circle(x, y, 100);
  y--;
}
