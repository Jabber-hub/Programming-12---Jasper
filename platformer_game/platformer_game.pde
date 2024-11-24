import fisica.*;
FWorld world;

color white       = #ffffff;
color black       = #000000;
color grey        = #b5b5b5;
color green       = #00ff00;
color red         = #ff0000;
color blue        = #0000ff;
color cyan        = #00ffff;
color orange      = #f0a000;
color brown       = #996633;

PImage map, stone, ice, treeTrunk, leaves, leftLeaves, rightLeaves, topTrunk, trampoline, lava, spike;
int gridSize = 32;
float zoom = 1.5;

//keyboard
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey;
FPlayer player;

float cameraX, cameraY;


void setup() {
  size(600, 600);
  Fisica.init(this);

  loadImages();       // Load all required images first
  world = new FWorld(-2000, -2000, 2000, 2000); // Initialize world early
  world.setGravity(0, 900);

  loadPlayer();       // Initialize the player and add it to the world
  loadWorld(map);     // Load the world and process the map AFTER player
}


void loadWorld(PImage img) {
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y); //color of pixel
      color s = img.get(x, y+1); //color of pixel below
      color w = img.get(x-1, y); //color of pixel west
      color e = img.get(x+1, y); //color of pixel east
      if (alpha(c) > 250) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setStatic(true);
        world.add(b);

        if (c == black) { //brick
          b.attachImage(stone);
          b.setFriction(1);
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
          trampoline.resize(gridSize, gridSize+30);
          b.attachImage(trampoline);
          b.setRestitution(1.3);
          b.setName("trampoline");
        } else if (c == green && w == green && e == green && s != brown) { //leaves
          b.attachImage(leaves);
          b.setName("leaves");
        } else if (c == green && w != green) { //left leaves
          b.attachImage(leftLeaves);
          b.setName("leftLeaves");
        } else if (c == green && e != green) { //right leaves
          b.attachImage(rightLeaves);
          b.setName("rightLeaves");
        } else if (c == brown) { //trunk
          b.attachImage(treeTrunk);
          b.setName("treeTrunk");
          b.setSensor(true);
        } else if (c == green && s == brown) { //trunk
          b.attachImage(topTrunk);
          b.setName("topTrunk");
        } else if (c == red) {
          lava.resize(gridSize, gridSize);
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
  background(#A6D7FC);
  pushMatrix();

  if (!player.die && !player.falling) {
    // Camera tracks the player when alive and not falling
    translate(-player.getX() * zoom + width / 2, -650);
    // Update cameraX and cameraY dynamically to track the player
    cameraX = player.getX();
    cameraY = player.getY();
  } else if (player.falling) {
    // Camera fixed when the player is falling
    translate(-cameraX * zoom + width / 2, -650);
  } else if (player.die) {
    // Camera fixed when the player dies
    translate(-cameraX * zoom + width / 2, -650);
  }

  scale(zoom);

  // Step the physics world
  world.step();

  // Draw all objects except the player
  for (Object obj : world.getBodies()) {
    if (obj instanceof FBody && obj != player) {
      FBody body = (FBody) obj;
      body.draw(this);
    }
  }

  // Draw the player last to render it in front
  player.draw(this);

  popMatrix();
}



void loadImages() {
  map = loadImage("map2.png");
  stone = loadImage("brick.png");
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  topTrunk = loadImage("tree_intersect.png");
  leaves = loadImage("treetop_center.png");
  leftLeaves = loadImage("treetop_w.png");
  rightLeaves = loadImage("treetop_e.png");
  lava = loadImage("lava0.png");
  spike = loadImage("spike.png");
  trampoline = loadImage("trampoline.png");
}
