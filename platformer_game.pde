import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import fisica.*;

FWorld world;
Minim minim;

//Sound effects
AudioPlayer Kill, Jump, Win, Game_over, Fall, Thwomp, Theme, bigJump;

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
color yellow      = #fff000;
color maroon      = #600000;
color hbBlue      = #4444ee;
color thwompPink  = #ff7777;
color winGreen    = #aaccaa;


PImage map, winBlock, Hammer, bridge, stone, ice, treeTrunk, leaves, leftLeaves, rightLeaves, topTrunk, trampoline, lava, spike;
//mario animations
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;

//enemies
PImage[] goomba;
PImage[] hammerbro;
PImage[] thwomp;

int gridSize = 32;
float zoom = 1.5;

//keyboard
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey, spacekey;
FPlayer player;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

float cameraX, cameraY;

// Mode framework
final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAME_OVER = 3;
final int WON = 4;

int mode = INTRO; // Start in the intro mode

boolean keyHandled = false;

//BUTTON
boolean mouseReleased;
boolean wasPressed;

Button[] myButtons;

PFont retro;

//GIF
gif intro, game, gameover, win;

void setup() {
  size(600, 600);//, P2D);
  fullScreen();
  Fisica.init(this);

  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();

  loadImages();
  world = new FWorld(-3000, -3000, 3000, 3000);
  world.setGravity(0, 900);

  loadPlayer();
  loadWorld(map);
  
  //Buttons
  myButtons = new Button[2];
  myButtons[0] = new Button("START", width/2, height/2 + 100, 250, 100, black, white);
  myButtons[1] = new Button("RETRY", width/2, height/2 + 100, 250, 100, white, black);
  
  retro = createFont("Retro Gaming.ttf", 75);
  
  //GIFS
  intro = new gif("Intro/frame_", "_delay-0.2s.gif", 10, 20, 0, 0, width, height);
  game = new gif("Game/frame_", "_delay-0.2s.gif", 4, 15, 0, 0, width, height);
  gameover = new gif("GameOver/frame_", "_delay-0.5s.gif", 2, 3, 0, 0, width, height);
  win = new gif("Win/frame_", "_delay-0.01s.gif", 4, 7, 0, 0, width, height);

  //minim
  minim    = new Minim(this);
  Jump    = minim.loadFile("jump.wav");
  Win     = minim.loadFile("win.wav");
  Kill     = minim.loadFile("kill.wav");
  Game_over = minim.loadFile("gameover.wav");
  Fall = minim.loadFile("fall.wav");
  Thwomp = minim.loadFile("thwomp.mp3");
  Theme = minim.loadFile("theme.mp3");
  bigJump = minim.loadFile("bigJump.wav");
}


void loadWorld(PImage img) {
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y); //color of pixel
      color s = img.get(x, y+1); //color of pixel below
      color w = img.get(x-1, y); //color of pixel west
      color e = img.get(x+1, y); //color of pixel east
      if (c == black || c == winGreen ||c == cyan || c == grey || c == maroon || c == white || c == green || c == brown) {//alpha(c) > 250) {
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
          b.setFriction(0.01);
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
          b.setName("leaves");
        } else if (c == green && e != green) { //right leaves
          b.attachImage(rightLeaves);
          b.setName("leaves");
        } else if (c == brown) { //trunk
          b.attachImage(treeTrunk);
          b.setName("treeTrunk");
          b.setSensor(true);
        } else if (c == green && s == brown) { //trunk
          b.attachImage(topTrunk);
          b.setName("leaves");
        } else if (c == maroon) {
          b.attachImage(ice);
          b.setFriction(0.01);
          b.setName("wall");
        } else if (c == winGreen) {
          winBlock.resize(gridSize, gridSize);
          b.attachImage(winBlock);
          b.setFriction(1);
          b.setName("win");
        }
      } else if (c == red) {
        FLava lv = new FLava(x*gridSize, y*gridSize);
        terrain.add(lv);
        world.add(lv);
      } else if (c == pink) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      } else if (c == yellow) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      } else if (c == hbBlue) {
        FHammerBro hmb = new FHammerBro(x*gridSize, y*gridSize);
        enemies.add(hmb);
        world.add(hmb);
      } else if (c == thwompPink) {
        FThwomp thw = new FThwomp(x*gridSize + 16, y*gridSize + 15);
        enemies.add(thw);
        world.add(thw);
      }
    }
  }
}


void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  switch (mode) {
    case INTRO:
      drawIntro();
      break;
    case GAME:
      drawGame();
      break;
    case PAUSE:
      drawPause();
      break;
    case GAME_OVER:
      drawGameOver();
      break;
    case WON:
      drawGameWon();
      break;
  }
  click();
  textFont(retro);
}

void drawIntro() {
  background(white);
  intro.show();
  textAlign(CENTER, CENTER);
  textSize(60);
  fill(#A9D8F0);
  text("Mario's Winter", width / 2, height / 2 - 75);
  text("Wonderland", width / 2, height / 2 - 25);
  myButtons[0].show();
  
  
  if (myButtons[0].clicked) {
      mode = GAME;
      Kill.rewind();
      Kill.play();
      Theme.rewind();
      Theme.play();
    }
}
 
void drawGame() {
  drawWorld();
  actWorld();
  game.show();

  if (keyPressed && key == 'p' && !keyHandled) {
    mode = PAUSE;
    keyHandled = true; // Mark the key as handled
    Theme.pause();
  }

  if (!keyPressed) {
    keyHandled = false; // Reset when the key is released
  }
}


void drawPause() {
  background(white);
  textAlign(CENTER, CENTER);
  textSize(32);
  fill(black);
  text("Paused", width / 2, height / 2 - 50);
  textSize(16);
  text("Press 'P' to Resume", width / 2, height / 2);
  game.show();

  if (keyPressed && key == 'p' && !keyHandled) {
    mode = GAME;
    keyHandled = true; // Mark the key as handled
    Theme.play();
  }

  if (!keyPressed) {
    keyHandled = false; // Reset when the key is released
  }
}


void drawGameOver() {
  background(white);
  Theme.pause();
  Theme.rewind();
  gameover.show();
  textAlign(CENTER, CENTER);
  textSize(50);
  fill(red);
  text("Game Over", width / 2, height / 2 - 50);

  myButtons[1].show();
  
  
  if (myButtons[1].clicked) {
      resetGame();
      mode = GAME;
      Kill.rewind();
      Kill.play();
      Theme.rewind();
      Theme.play();
    }
}

void drawGameWon() {
  background(white);
  Theme.pause();
  Theme.rewind();
  win.show();
  game.show();
  textAlign(CENTER, CENTER);
  textSize(50);
  fill(green);
  text("You Win!", width / 2, height / 2 - 50);
  myButtons[0].show();
  
  if (myButtons[0].clicked) {
      resetGame();
      mode = GAME;
      Theme.rewind();
      Theme.play();
    }
}

void resetGame() {
  // Reset player, enemies, terrain, and other game states
  world.clear();
  loadWorld(map);
  loadPlayer();
}


void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void drawWorld() {
  background(#A6D7FC);
  pushMatrix();

  //scale(zoom);
  //translate(width/2/zoom - player.getX(), height/2/zoom - player.getY());
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
  //text("here", player.getX(), player.getY());
}

void  click() {
  mouseReleased = false;
  if (mousePressed) {
    wasPressed = true;
  }
  if (wasPressed && mousePressed == false) {
    mouseReleased = true;
    wasPressed = false;
  }
}

ArrayList<PImage> lavaImages;

void loadImages() {
  map = loadImage("map.png");
  stone = loadImage("brick.png");
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  topTrunk = loadImage("tree_intersect1.png");
  leaves = loadImage("treetop_center1.png");
  leftLeaves = loadImage("treetop_w1.png");
  rightLeaves = loadImage("treetop_e1.png");
  spike = loadImage("spike.png");
  trampoline = loadImage("trampoline.png");
  bridge = loadImage("bridge_center.png");
  winBlock = loadImage("WinBlock.png");



  lavaImages = new ArrayList<PImage>();
  for (int i = 0; i <= 8; i++) {
    lavaImages.add(loadImage("lava" + i + ".png")); // Assumes files are named lava0.png, lava1.png, ...
  }

  //Mario animations
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");

  //ENEMIES
  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize-5, gridSize-5);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize-5, gridSize-5);

  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("hammerbro0.png");
  hammerbro[0].resize(gridSize-5, gridSize-5);
  hammerbro[1] = loadImage("hammerbro1.png");
  hammerbro[1].resize(gridSize-5, gridSize-5);
  
  Hammer = loadImage("hammer.png");
  
  thwomp = new PImage[2];
  thwomp[0] = loadImage("thwomp0.png");
  thwomp[0].resize(gridSize*2, gridSize*2);
  thwomp[1] = loadImage("thwomp1.png");
  thwomp[1].resize(gridSize*2, gridSize*2);

  action = idle;
}
