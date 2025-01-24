import java.awt.Robot;

color black = #000000;
color white = #FFFFFF;

//map variables
int gridSize;
PImage map;

//texture
PImage brick;

Robot rbt;

boolean wkey, akey, skey, dkey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ;
float leftRightHeadAngle, upDownHeadAngle;



void setup() {
  //size(displayWidth, displayHeight, P3D);
  fullScreen(P3D);
  //noCursor();
  textureMode(NORMAL);

  wkey = akey = skey = dkey = false;
  eyeX = width/2;
  eyeY = height/2;
  eyeZ = 0;
  focusX = width/2;
  focusY = height/2;
  focusZ = 10;
  tiltX = 0;
  tiltY = 1;
  tiltZ = 0;
  leftRightHeadAngle = radians(90);

  //initialize map
  map = loadImage("map.png");
  gridSize = 100;

  //textures
  brick = loadImage("Stone_Bricks.png");

  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

void draw() {
  background(0);
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);
  drawFloor();
  drawFocalPoint();
  controlCamera();
  drawMap();
}

void drawFloor() {
  stroke(255);
  for (int x = -2000; x <= 2000; x = x + 100) {
    line(x, height, -2000, x, height, 2000);
    line(-2000, height, x, 2000, height, x);
  }
}

void drawFocalPoint() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  sphere(5);
  popMatrix();
}

void controlCamera() {

  if (wkey) {
    eyeX = eyeX + cos(leftRightHeadAngle)*10;
    eyeZ = eyeZ + sin(leftRightHeadAngle)*10;
  }
  if (skey) {
    eyeX = eyeX - cos(leftRightHeadAngle)*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle)*10;
  }
  if (akey) {
    eyeX = eyeX + cos(leftRightHeadAngle-radians(90))*10;
    eyeZ = eyeZ + sin(leftRightHeadAngle-radians(90))*10;
  }
  if (dkey) {
    eyeX = eyeX - cos(leftRightHeadAngle-radians(90))*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle-radians(90))*10;
  }

  leftRightHeadAngle = leftRightHeadAngle + (mouseX - pmouseX)*0.01;
  upDownHeadAngle = upDownHeadAngle + (mouseY - pmouseY)*0.01;
  if (upDownHeadAngle > PI/2.5) upDownHeadAngle = PI/2.5;
  if (upDownHeadAngle > -PI/2.5) upDownHeadAngle = -PI/2.5;

  focusX = eyeX + cos(leftRightHeadAngle)*300;
  focusZ = eyeZ + sin(leftRightHeadAngle)*300;
  focusY = eyeY + tan(upDownHeadAngle)*300;

  //wrapMouse();
  //rbt.mouseMove(width/2, height/2);
}

void drawMap() {
  for (int x = 0; x < map.width; x++) {
    for (int y = 0; y < map.height; y++) {
      color c = map.get(x, y);
      if (c != white) {
        texturedCube(x*gridSize-1500, height-gridSize, y*gridSize-2000, brick, gridSize);
        texturedCube(x*gridSize-1500, height-gridSize*2, y*gridSize-2000, brick, gridSize);
        texturedCube(x*gridSize-1500, height-gridSize*3, y*gridSize-2000, brick, gridSize);
        texturedCube(x*gridSize-1500, height-gridSize*4, y*gridSize-2000, brick, gridSize);
    }
    }
  }
}


void wrapMouse() { //wrapping mouse doesnt work on mac
  //Mr P said I dont need it
  //if (mouseX > width-2) rbt.mouseMove(2, mouseY);
  //else if (mouseX < 2) rbt.mouseMove(width-2, mouseY);
}
