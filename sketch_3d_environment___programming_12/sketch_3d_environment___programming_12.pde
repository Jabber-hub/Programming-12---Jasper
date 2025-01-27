import java.awt.Robot;

color black = #000000; //Stone bricks
color white = #FFFFFF; //Empty space
color green = #00ff00; //Oak plank

//map variables
int gridSize;
PImage map;

//texture
PImage brick;
PImage diamond;

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
  eyeY = height/2+250;
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

  diamond = loadImage("Diamond.png");

  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

void draw() {
  background(0);

  pointLight(255, 255, 255, eyeX, eyeY, eyeZ);
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);

  drawFloor(-2000, 2000, height, 100);
  drawFloor(-2000, 2000, height-gridSize*5, 100);
  drawFocalPoint();
  controlCamera();
  drawMap();
}

void drawFloor(int start, int end, int level, int gap) {
  stroke(255);
  strokeWeight(1);
  int x = start;
  int z = start;
  while (z < end) {
    texturedCube(x, level, z, brick, gap);
    x = x + gap;
    if (x >= end) {
      x = start;
      z = z + gap;
    }
  }
}

void drawFocalPoint() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  sphere(5);
  popMatrix();
}

void controlCamera() {

  if (wkey && canMoveForward()) {
    eyeX = eyeX + cos(leftRightHeadAngle)*10;
    eyeZ = eyeZ + sin(leftRightHeadAngle)*10;
  }
  if (skey && canMoveBack()) {
    eyeX = eyeX - cos(leftRightHeadAngle)*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle)*10;
  }
  if (akey && canMoveLeft()) {
    eyeX = eyeX + cos(leftRightHeadAngle-radians(90))*10;
    eyeZ = eyeZ + sin(leftRightHeadAngle-radians(90))*10;
  }
  if (dkey && canMoveRight()) {
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

boolean canMoveForward() {
  float fwdX, fwdZ;
  int mapX, mapY;

  fwdX = eyeX + cos(leftRightHeadAngle)*150;
  fwdZ = eyeZ + sin(leftRightHeadAngle)*150;

  mapX = int(fwdX+1500) / gridSize;
  mapY = int(fwdZ+2000) / gridSize;

  if (map.get(mapX, mapY) == white) {
    return true;
  } else {
    return false;
  }
}

boolean canMoveLeft() {
  float leftX, leftZ;
  int mapX, mapY;

  leftX = eyeX + cos(leftRightHeadAngle)*150;
  leftZ = eyeZ + sin(leftRightHeadAngle)*150;

  mapX = int(leftX+1500) / gridSize;
  mapY = int(leftZ+2000) / gridSize;

  if (map.get(mapX, mapY) == white) {
    return true;
  } else {
    return false;
  }
}

boolean canMoveRight() {
  float rightX, rightZ;
  int mapX, mapY;

  rightX = eyeX + cos(leftRightHeadAngle+radians(90))*150;
  rightZ = eyeZ + sin(leftRightHeadAngle+radians(90))*150;

  mapX = int(rightX+1500) / gridSize;
  mapY = int(rightZ+2000) / gridSize;

  if (map.get(mapX, mapY) == white) {
    return true;
  } else {
    return false;
  }
}

boolean canMoveBack() {
  float backX, backZ;
  int mapX, mapY;

  backX = eyeX - cos(leftRightHeadAngle)*150;
  backZ = eyeZ - sin(leftRightHeadAngle)*150;

  mapX = int(backX+1500) / gridSize;
  mapY = int(backZ+2000) / gridSize;

  if (map.get(mapX, mapY) == white) {
    return true;
  } else {
    return false;
  }
}

void drawMap() {
  for (int x = 0; x < map.width; x++) {
    for (int y = 0; y < map.height; y++) {
      color c = map.get(x, y);
      if (c == black) {
        texturedCube(x*gridSize-1500, height-gridSize, y*gridSize-2000, brick, gridSize);
        texturedCube(x*gridSize-1500, height-gridSize*2, y*gridSize-2000, brick, gridSize);
        texturedCube(x*gridSize-1500, height-gridSize*3, y*gridSize-2000, brick, gridSize);
        texturedCube(x*gridSize-1500, height-gridSize*4, y*gridSize-2000, brick, gridSize);
      }
      if (c == green) {
        texturedCube(x*gridSize-1500, height-gridSize, y*gridSize-2000, diamond, gridSize);
        texturedCube(x*gridSize-1500, height-gridSize*2, y*gridSize-2000, diamond, gridSize);
        texturedCube(x*gridSize-1500, height-gridSize*3, y*gridSize-2000, diamond, gridSize);
        texturedCube(x*gridSize-1500, height-gridSize*4, y*gridSize-2000, diamond, gridSize);
      }
    }
  }
}


void wrapMouse() { //wrapping mouse doesnt work on mac
  //Mr P said I dont need it
  //if (mouseX > width-2) rbt.mouseMove(2, mouseY);
  //else if (mouseX < 2) rbt.mouseMove(width-2, mouseY);
}
