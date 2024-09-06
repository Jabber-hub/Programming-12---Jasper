//Jasper
//Programming 12 intro project
//Sept 5

float sunY = 200;
float moonY = 1000;


void setup() {
  size(800, 600);
}

void draw() {
  if (sunY < -200) {
  background(#000000);
  } else {
  background(#BFD0FF);
}
  //background(#BFD0FF);
  moon();
  sun(200);
  noStroke();
  house();
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

void sun(int x) {
  fill(#EDBF02);
  stroke(#000000);
  line(150, sunY, 125, sunY);
  line(250, sunY, 275, sunY);
  line(200, sunY+50, 200, sunY+75);
  line(200, sunY-50, 200, sunY-75);
  line(225, sunY+25, 275, sunY+75);
  line(175, sunY-25, 125, sunY-75);
  line(225, sunY-25, 275, sunY-75);
  line(175, sunY+25, 125, sunY+75);
  circle(x, sunY, 100);

  sunY--;
  if (sunY < -1000) {
    sunY = 700;
  }
  
}

void moon() {
  fill(#FFF27C);
  circle(200, moonY, 75);
  noStroke();
  fill(#000000);
  circle(225, moonY, 75);
  
  moonY--;
  if(moonY < -900) {
  moonY = 800;
  }
}
