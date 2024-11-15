import fisica.*;
FWorld world;

color white = #ffffff;
color black = #000000;
color green = #009f00;
color red   = #ff0000;
color blue  = #0000ff;
color cyan  = #0ffff0;
color orange= #f0a000;
color brown = #996633;

PImage map, stone, ice, treeTrunk, treeTop;
int gridSize = 32;
float zoom = 1.5;

//keyboard
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey;
FPlayer player;


void setup() {
  size(600, 600);
  Fisica.init(this);


  map = loadImage("map.png");
  stone = loadImage("brick.png");
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  loadWorld(map);
  loadPlayer();
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);
      if (alpha(c) > 250) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setStatic(true);
        world.add(b);

        if (c == black) { //brick
          b.attachImage(stone);
          b.setFriction(4);
          b.setName("stone");
        } else if (c == cyan) {
          ice.resize(gridSize, gridSize);
          b.attachImage(ice);
          b.setFriction(0);
          b.setName("ice");
          
        } else if (c == green) {
          b.setFillColor(green);
        } else if (c == brown) {
          ice.resize(gridSize, gridSize);
          b.attachImage(treeTrunk);
          b.setName("treeTrunk");
          b.setSensor(true);
          
        } else if (c == red) {
          b.setFillColor(red);
        }
      }
    }
  }
}

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  background(white);
  drawWorld();
  player.act();
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();

  popMatrix();
}
