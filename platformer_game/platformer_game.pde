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
color pink        = #fb00ff;

PImage map, bridge, stone, ice, treeTrunk, leaves, leftLeaves, rightLeaves, topTrunk, trampoline, lava, spike;
int gridSize = 32;
float zoom = 1.5;

//keyboard
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey;
FPlayer player;
ArrayList<FGameObject> terrain;

float cameraX, cameraY;


void setup() {
  size(600, 600);//, P2D);
  Fisica.init(this);

  terrain = new ArrayList<FGameObject>();

  loadImages();
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);

  loadPlayer();
  loadWorld(map);
}


void loadWorld(PImage img) {
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y); //color of pixel
      color s = img.get(x, y+1); //color of pixel below
      color w = img.get(x-1, y); //color of pixel west
      color e = img.get(x+1, y); //color of pixel east
      if (c == black || c == cyan || c == grey || c == white || c == green || c == brown) {//alpha(c) > 250) {
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
        } 
      } else if (c == red) {
          FLava lv = new FLava(x*gridSize, y*gridSize);
          terrain.add(lv);
          world.add(lv);
        } else if (c == pink) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
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
  actWorld();
}

void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
}

void drawWorld() {
  background(#A6D7FC);
  pushMatrix();


  if (!player.die && !player.falling) {
    translate(-player.getX() * zoom + width / 2, -650);
    cameraX = player.getX();
    cameraY = player.getY();
  } else {
    translate(-cameraX * zoom + width / 2, -650);
  }

  scale(zoom);

  world.step();

  for (Object obj : world.getBodies()) {
    if (obj instanceof FBody && obj != player) {
      FBody body = (FBody) obj;
      body.draw(this);
    }
  }

  // Draw player to render in front of map
  player.draw(this);

  popMatrix();
}

ArrayList<PImage> lavaImages;

void loadImages() {
  map = loadImage("map3.png");
  stone = loadImage("brick.png");
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  topTrunk = loadImage("tree_intersect.png");
  leaves = loadImage("treetop_center.png");
  leftLeaves = loadImage("treetop_w.png");
  rightLeaves = loadImage("treetop_e.png");
  spike = loadImage("spike.png");
  trampoline = loadImage("trampoline.png");
  bridge = loadImage("bridge_center.png");
  
  lavaImages = new ArrayList<PImage>();
    for (int i = 0; i <= 8; i++) {
        lavaImages.add(loadImage("lava" + i + ".png")); // Assumes files are named lava0.png, lava1.png, ...
    }
}
