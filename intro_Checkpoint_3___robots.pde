color black     = #000000;
color white     = #ffffff;
color darkGrey  = #463f3a;
color grey      = #8a817c;
color lightGrey = #bcb8b1;
color darkRed   = #660708;
color red       = #ba181b;
color lightRed  = #e5383b;


void setup() {
  size(800, 600);
}

void draw() {
  robot(150, 200, 2);
}

void robot(int x, int y, int s) {
  pushMatrix();
  translate(x, y);

  head();
  body();
  track();
  track();

  popMatrix();
}

void head() {
  strokeWeight(2);
  stroke(black);
  line(65, -30, 30, -60);
  line(85, -30, 120, -60);
  
  //left eye
  strokeWeight(1);
  fill(grey);
  circle(25, -75, 75);
  fill(red);
  circle(25, -75, 40);
  
  //right eye
  fill(grey);
  circle(125, -75, 75);
  fill(red);
  circle(125, -75, 40);
  
  //stalk
  fill(darkRed);
  rect(62.5, -75, 25, 65);
  rect(50, -10, 50, 10);
  
  
}

void body() {
  //body
  fill(darkGrey);
  rect(0, 0, 150, 50);
  fill(darkRed);
  rect(0, 50, 150, 100);
  
  //left arm  
  fill(grey);
  rect(-10, 40, 40, 20);
  rect(-10, 61, 40, 20);
  //right arm
  rect(120, 40, 40, 20);
  rect(120, 61, 40, 20);
}

void track() {
  fill(#715B45);
  rect(-50, 90, 50, 100);
}
