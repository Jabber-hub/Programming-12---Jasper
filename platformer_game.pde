import fisica.*;
FWorld world;

color white = #ffffff;
color black = #000000;
color green = #00ff00;
color red   = #ff0000;
color blue  = #0000ff;
color orange= #f0a000;
color brown = #996633;

PImage map;
int gridSize = 32;

void setup() {
  size(600, 600);
  Fisica.init(this);
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
}

void draw() {
  world.step();
  world.draw();
}
