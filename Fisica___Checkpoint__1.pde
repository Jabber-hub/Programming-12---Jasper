
import fisica.*;

//palette
color blue   = color(29, 178, 242);
color brown  = color(166, 120, 24);
color green  = color(74, 163, 57);
color red    = color(224, 80, 61);
color yellow = color(242, 215, 16);

//assets
PImage redBird;
PImage chicken;

float cloudX = 50;

boolean gravity = true;
boolean spawn = true;

FPoly topPlatform;
FPoly bottomPlatform;

//fisica
FWorld world;

void setup() {
  //make window
  fullScreen();

  //load resources
  redBird = loadImage("red-bird.png");
  chicken = loadImage("chicken.png");

  //initialise world
  makeWorld();

  //add terrain to world
  makeTopPlatform();
  makeBottomPlatform();
}

//===========================================================================================

void makeWorld() {
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 900);
}

//===========================================================================================

void makeTopPlatform() {
  topPlatform = new FPoly();

  //plot the vertices of this platform
  topPlatform.vertex(100, 300);
  topPlatform.vertex(100, 500);
  topPlatform.vertex(300, 500);
  topPlatform.vertex(300, 300);
  topPlatform.vertex(280, 300);
  topPlatform.vertex(280, 480);
  topPlatform.vertex(280, 480);
  topPlatform.vertex(120, 480);
  topPlatform.vertex(120, 300);

  // define properties
  topPlatform.setStatic(true);
  topPlatform.setFillColor(brown);
  topPlatform.setFriction(0.1);

  //put it in the world
  world.add(topPlatform);
}

//===========================================================================================

void makeBottomPlatform() {
  bottomPlatform = new FPoly();

  //plot the vertices of this platform
  bottomPlatform.vertex(width+100, height*0.6);
  bottomPlatform.vertex(300, height*0.8);
  bottomPlatform.vertex(300, height*0.8+100);
  bottomPlatform.vertex(width+100, height*0.6+100);

  // define properties
  bottomPlatform.setStatic(true);
  bottomPlatform.setFillColor(brown);
  bottomPlatform.setFriction(0);

  //put it in the world
  world.add(bottomPlatform);
}


//===========================================================================================

void draw() {


  println("x: " + mouseX + " y: " + mouseY);
  background(blue);
  cloud(cloudX, 100, 50);
  cloudX += 1;

  if (cloudX > width + 100) {
    cloudX = -100;
  }
  if (frameCount % 50 == 0 && spawn) {  //Every 20 frames ...
    //makeCircle();
    //makeBlob();
    makeBox();
    makeBird();
  }

  if (gravity) {
  world.step();  //get box2D to calculate all the forces and new positions
  }
  world.draw();  //ask box2D to convert this world to processing screen coordinates and draw
  

  cloud(cloudX+200, 150, 75); //cloud
  gravityButton(100, 100, 100, 50, "gravity");
  spawnButton(250, 100, 100, 50, "spawn");
}


//===========================================================================================

void makeCircle() {
  FCircle circle = new FCircle(50);
  circle.setPosition(random(width), -5);

  //set visuals
  circle.setStroke(0);
  circle.setStrokeWeight(2);
  circle.setFillColor(red);

  //set physical properties
  circle.setDensity(0.2);
  circle.setFriction(1);
  circle.setRestitution(1);

  //add to world
  world.add(circle);
}

//===========================================================================================

void makeBlob() {
  FBlob blob = new FBlob();

  //set visuals
  blob.setAsCircle(random(width), -5, 50);
  blob.setStroke(0);
  blob.setStrokeWeight(2);
  blob.setFillColor(yellow);

  //set physical properties
  blob.setDensity(1);
  blob.setFriction(1);
  blob.setRestitution(0.25);

  //add to the world
  world.add(blob);
}

//===========================================================================================

void makeBox() {
  FBox box = new FBox(50, 50);
  box.setPosition(random(width), -5);

  //set visuals
  box.setStroke(0);
  box.setStrokeWeight(2);
  box.setFillColor(green);

  PImage resizedChicken = chicken.copy();  // Create a copy of the chicken image
  resizedChicken.resize(50, 50);  // Resize the copy to 50x50

  // Attach the resized image to the box
  box.attachImage(resizedChicken);

  //set physical properties
  box.setDensity(0.2);
  box.setFriction(8);
  box.setRestitution(0.1);
  world.add(box);
}

//===========================================================================================

void makeBird() {
  FCircle bird = new FCircle(48);
  bird.setPosition(random(width), -5);

  //set visuals
  bird.attachImage(redBird);

  //set physical properties
  bird.setDensity(0.1);
  bird.setFriction(0.1);
  bird.setRestitution(0.8);
  world.add(bird);
}

void cloud(float x, float y, int d) {
  noStroke();
  fill(255);
  circle(x, y, d);
  circle(x-25, y+10, d+10);
  circle(x+15, y+15, d+15);
}

void gravityButton(int x, int y, int w, int h, String t) {
  if (gravity) {
  fill(0);
  }else fill(255);
  rectMode(CENTER);
  textMode(CENTER);
  rect(x, y, w, h);
  if (gravity) {
  fill(255);
  }else fill(0);
  text(t, x-15, y);
}

void spawnButton(int x, int y, int w, int h, String t) {
  if (spawn) {
  fill(0);
  }else fill(255);
  rectMode(CENTER);
  textMode(CENTER);
  rect(x, y, w, h);
  if (spawn) {
  fill(255);
  }else fill(0);
  text(t, x-15, y);
}

void mouseReleased() {
if(mouseX > 50 && mouseX < 150 && mouseY > 75 && mouseY < 125) {
gravity = !gravity;
}
if(mouseX > 200 && mouseX < 300 && mouseY > 75 && mouseY < 125) {
spawn = !spawn;
}
}
