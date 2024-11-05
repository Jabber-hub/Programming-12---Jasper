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

//keyboard
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey;

void setup() {
  size(600, 600);
  Fisica.init(this);
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);

  map = loadImage("map.png");

  loadWorld(map);
  loadPlayer();
}

void loadWorld(PImage img) {
for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);
      if (c == black) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setStatic(true);
        world.add(b);
      }
    }
  }
}

void draw() {
  background(white);
  world.step();
  world.draw();
}
