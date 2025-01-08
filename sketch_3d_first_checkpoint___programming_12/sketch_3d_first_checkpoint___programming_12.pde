float rotx, roty;


void setup() {
  size(800, 800, P3D);
}

void draw() {
  background(255);
  //cube(width/2, height/2, 0, #ff0000, 200);
  cube(200, 200, 100, #ff00ff, 100);

  ball(500, 500, 200, #0000ff, 100);
}

void cube(float x, float y, float z, color c, float size) {
  pushMatrix();
  translate(x, y, z);
  rotateX(rotx);
  rotateY(roty);

  fill(c);
  stroke(0);
  strokeWeight(3);
  //rotateZ();
  box(size); //W H D
  popMatrix();
}

void ball(float x, float y, float z, color c, float size) {
  pushMatrix();
  translate(x, y, z);
  rotateX(rotx);
  rotateY(roty);

  fill(c);
  stroke(0);
  strokeWeight(3);
  //rotateZ();
  sphere(size); //W H D
  popMatrix();
}

void mouseDragged() {
  rotx = rotx + (pmouseY - mouseY)*0.005;
  roty = roty + (pmouseX - mouseX)*-0.005;
}
