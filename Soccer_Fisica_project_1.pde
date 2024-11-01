import fisica.*;

FWorld world;

//colors
color white  = #FFFFFF;
color black  = #000000;
color green  = #75AF6E;
color yellow = #e9c46a;
color orange = #f4a261;
color red    = #e76f51; 
color blue   = #89AAB9;

//Images
PImage soccerball;
PImage house;

//GIF
gif crowd, intro;

//button
Button[] myButtons;
boolean mouseReleased, wasPressed;
boolean ai;

//Mode variables
int mode;
final int INTRO    = 0;
final int GAME     = 1;
final int GAMEOVER = 2;
int bluescore, redscore;
boolean redwin, bluewin;

//font
PFont retro;

//keyboard
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey, vkey, slashkey;

//hit ground
boolean hitGround(FBox player) {
  ArrayList<FContact> contactList = player.getContacts();
  for (int i = 0; i < contactList.size(); i++) {
    FContact myContact = contactList.get(i);
    if (myContact.contains(ground)) {
      return true;
    }
  }
  return false;
}

//F SHAPES
FPoly ground;
FPoly leftCrossbar;
FPoly rightCrossbar;
FBox leftPlayer;
FBox rightPlayer;
FCircle ball;



void setup() {
  fullScreen();
  
  //font
  retro = createFont("Retro Gaming.ttf", 75);

  //Image
  soccerball = loadImage("ball.png");
  house = loadImage("house.png");

  //initialise world
  createWorld();

  //add objects and terrain
  createBodies();
  createPlatforms();

  //mode framework
  mode = INTRO;

  //gif
  crowd = new gif("crowd/frame_", "_delay-0.1s.gif", 4, 10, 0, 0, width, height);
  intro = new gif("intro/frame_", "_delay-0.01s.gif", 63, 5, 0, 0, width, height);

  //button
  myButtons = new Button[3];
  myButtons[0] = new Button("1P", width/4, height/2, 500, 300, black, white);
  myButtons[1] = new Button("2P", width - 400, height/2, 500, 300, black, white);
  myButtons[2] = new Button(house, 100, 100, 100, 50, black, white);
}

void createWorld() {
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 980);
  world.setEdges();
}

void createPlatforms() {
  //Blue Platform =============================
  ground = new FPoly();

  //plot the vertices of this platform
  ground.vertex(0, height-300);
  ground.vertex(150, height-300);
  ground.vertex(350, height-100);
  ground.vertex(width-350, height-100);
  ground.vertex(width-150, height-300);
  ground.vertex(width, height-300);
  ground.vertex(width, height);
  ground.vertex(0, height);

  // define properties
  ground.setStatic(true);
  ground.setFillColor(green);
  ground.setFriction(0.1);

  //put it in the world
  world.add(ground);

  //LEFT CROSSBAR =============================
  leftCrossbar = new FPoly();

  //plot the vertices of this platform
  leftCrossbar.vertex(0, 0);
  leftCrossbar.vertex(300, 0);
  leftCrossbar.vertex(300, 300);
  leftCrossbar.vertex(200, 400);
  leftCrossbar.vertex(0, 400);

  // define properties
  leftCrossbar.setStatic(true);
  leftCrossbar.setFillColor(green);
  leftCrossbar.setFriction(0.1);

  //put it in the world
  world.add(leftCrossbar);

  //LEFT CROSSBAR =============================
  rightCrossbar = new FPoly();

  //plot the vertices of this platform
  rightCrossbar.vertex(width, 0);
  rightCrossbar.vertex(width-300, 0);
  rightCrossbar.vertex(width-300, 300);
  rightCrossbar.vertex(width-200, 400);
  rightCrossbar.vertex(width, 400);


  // define properties
  rightCrossbar.setStatic(true);
  rightCrossbar.setFillColor(green);
  rightCrossbar.setFriction(0.1);

  //put it in the world
  world.add(rightCrossbar);
}

void createBodies() {
  //LEFTPLAYER ======================================
  leftPlayer = new FBox(100, 100);

  leftPlayer.setPosition(width-1000, height- 200);

  //set visuals
  leftPlayer.setStroke(0);
  leftPlayer.setStrokeWeight(2);
  leftPlayer.setFillColor(blue);

  //set physical properties
  leftPlayer.setDensity(1);
  leftPlayer.setFriction(1);
  leftPlayer.setRestitution(0.1);

  world.add(leftPlayer);

  //RIGHTPLAYER ======================================
  rightPlayer = new FBox(100, 100);

  rightPlayer.setPosition(width-500, height- 200);

  //set visuals
  rightPlayer.setStroke(0);
  rightPlayer.setStrokeWeight(2);
  rightPlayer.setFillColor(red);

  //set physical properties
  rightPlayer.setDensity(1);
  rightPlayer.setFriction(1);
  rightPlayer.setRestitution(0.1);

  world.add(rightPlayer);

  //BALL ==============================================
  ball = new FCircle(60);
  ball.setPosition(width/2, -5);

  //set visuals
  soccerball.resize(60, 60);
  ball.attachImage(soccerball);

  //set physical properties
  ball.setDensity(0.2);
  ball.setFriction(0.1);
  ball.setRestitution(1.1);

  //add to world
  world.add(ball);
}

void draw() {
  //click();
  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == GAMEOVER) {
    gameover();
  } else {
    println("Error: Mode = " + mode);
  }
}
