class FThwomp extends FGameObject {

  float speed = 40;
  int direction = 1;
  final int L = -1;
  final int R = 1;

  int lastWallCollisionFrame = 0;
  int wallCooldownFrames = 20;

  int frame = 0;
  float delay = 10;
  int lastUpdateTime = 0;

  boolean die;

  int state;
  final int still = 0;
  final int down = 1;
  final int up = 2;

  float downTimer = 15;
  float upTimer = 30;
  float aggroTimer = 25;

  boolean playerSensed;
  boolean touchWall;
  boolean loseAggro;

  float restX;
  float restY;

  FBox thwompSensor;

  FThwomp(float x, float y) {
    super(gridSize*2, gridSize*2);
    setPosition(x, y);
    setRestitution(0);
    restX = x;
    restY = y;
    setRotatable(false);
    setStatic(true);
    setDensity(90000);
    setName("thwomp");

    thwompSensor = new FBox(gridSize*2, gridSize*7 + 1);
    thwompSensor.setStaticBody(true);
    thwompSensor.setSensor(true);
    thwompSensor.setFill(white, 0);
    thwompSensor.setNoStroke();
    thwompSensor.setName("thwompSensor");
    world.add(thwompSensor);
  }

  void act() {
    animate();
    move();
    collide();

    thwompSensor.setPosition(getX(), getY() + (gridSize*4.5)+1);
  }
  void animate() {
    if (sTouching(thwompSensor, "player")) { //check for player
      playerSensed = true;
      Thwomp.rewind();
      Thwomp.play();
    }

    if (playerSensed) {
      
      downTimer--;
      if (downTimer<=0) {
        state = down;
        downTimer = 25;
        playerSensed = false;
      }
    }

    if (isTouching("wall")) { //go up if hit bottom
      touchWall = true;
    }

    if (touchWall) {
      upTimer--;
      if (upTimer<= 0) {
        state = up;
      }
    }

    if (dist(getX(), getY(), restX, restY) < 5 && upTimer <= 0) {
      loseAggro = true;
      setPosition(restX, restY);
      touchWall = false;
      upTimer = 30;
    }

    if (loseAggro) {
      aggroTimer--;
      if (aggroTimer<= 0) {
        state = still;
        aggroTimer = 25;
        loseAggro = false;
      }
    }

    if (state == down) {
      this.setStatic(false);
      attachImage(thwomp[1]);
    } else if (state == up) {
      this.setStatic(false);
      this.setVelocity(0, -300);
      attachImage(thwomp[1]);
    } else if (state == still) {
      this.setStatic(true);
      attachImage(thwomp[0]);
    } else state = still;

    if (state == down) {
      println("State: Down");
    } else if (state == up) {
      println("State: Up");
    } else if (state == still) {
      println("State: Still");
    }
    //println("Mouse X: " + mouseX + ", Mouse Y: " + mouseY);
  }

  void move() {
  }

  void collide() {
  }
}
