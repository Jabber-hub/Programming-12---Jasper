import fisica.*;
FWorld world;

color white       = #ffffff;
color black       = #000000;
color grey        = #b5b5b5;
color middleGreen = #009f00;
color green       = #00ff00;
color rightGreen  = #00ff70;
color red         = #ff0000;
color blue        = #0000ff;
color cyan        = #00ffff;
color orange      = #f0a000;
color brown       = #996633;
color intBrown    = #ddaa00;

PImage map, stone, ice, treeTrunk, leaves, leftLeaves, rightLeaves, topTrunk, lava, spike;
int gridSize = 32;
float zoom = 1.5;

//keyboard
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey;
FPlayer player;


void setup() {
  size(600, 600);
  Fisica.init(this);


  loadImages();
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
          
        } else if (c == cyan) { //ice
          ice.resize(gridSize, gridSize);
          b.attachImage(ice);
          b.setFriction(0);
          b.setName("ice");
          
        } else if (c == grey) { //ice
          ice.resize(gridSize, gridSize);
          b.attachImage(spike);
          b.setName("spike");
          
        } else if (c == white) { //trampoline
          b.setRestitution(1.3);
          b.setName("trampoline");
          
        } else if (c == middleGreen) { //leaves
          b.attachImage(leaves);
          b.setName("leaves");
          
        } else if (c == green) { //leaves
          b.attachImage(leftLeaves);
          b.setName("leftLeaves");
          
        } else if (c == rightGreen) { //leaves
          b.attachImage(rightLeaves);
          b.setName("rightLeaves");
          
        } else if (c == brown) { //trunk
          b.attachImage(treeTrunk);
          b.setName("treeTrunk");
          b.setSensor(true);
          
        } else if (c == intBrown) { //trunk
          b.attachImage(topTrunk);
          b.setName("topTrunk");
          
        } else if (c == red) {
          b.attachImage(lava);
          b.setName("lava");
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

void loadImages() {
  map = loadImage("map1.png");
  stone = loadImage("brick.png");
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  topTrunk = loadImage("tree_intersect.png");
  leaves = loadImage("treetop_center.png");
  leftLeaves = loadImage("treetop_w.png");
  rightLeaves = loadImage("treetop_e.png");
  lava = loadImage("lava0.png");
  spike = loadImage("spike.png");
}
