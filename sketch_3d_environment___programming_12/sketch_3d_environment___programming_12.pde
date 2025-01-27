import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;

AudioPlayer snowball;

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

boolean wkey, akey, skey, dkey, spacekey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ;
float leftRightHeadAngle, upDownHeadAngle;

//game objects
ArrayList<GameObject> objects;

void setup() {
  objects = new ArrayList<GameObject>();

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
  
  //minim
  minim = new Minim(this);
  snowball = minim.loadFile("snowball.mp3");
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
  shoot();

  int i = 0;
  while (i < objects.size()) {
    GameObject obj = objects.get(i);
    obj.act();
    obj.show();
    if (obj.lives == 0) {
      objects.remove(i);
    } else {
      i++;
    }
  }
}




void wrapMouse() { //wrapping mouse doesnt work on mac
  //Mr P said I dont need it
  //if (mouseX > width-2) rbt.mouseMove(2, mouseY);
  //else if (mouseX < 2) rbt.mouseMove(width-2, mouseY);
}
