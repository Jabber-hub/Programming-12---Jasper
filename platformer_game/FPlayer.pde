class FPlayer extends FGameObject {
  boolean falling = false;
  boolean fall = false;
  boolean die = false;
  int deathStartFrame = -1;
  int dieWaitFrames = 120;
  int frame = 0;

  int direction;
  final int L = -1;
  final int R = 1;

  FBox bottomSensor;

  boolean jumping = false;
  int jumpStartFrame = 0;
  int maxJumpFrames = 12;
  float jumpImpulse = -70;

  FPlayer() {
    super(gridSize-10, gridSize-5);
    setPosition(0, 400);
    setRotation(0);
    setDensity(1);
    direction = R;
    setName("player");
    setFillColor(color(255, 0, 0));
    setRotatable(false);

    //bottom sensor
    bottomSensor = new FBox(gridSize - 11, 5);
    bottomSensor.setStaticBody(false);
    bottomSensor.setSensor(true);
    bottomSensor.setFill(white, 0);
    bottomSensor.setNoStroke();
    bottomSensor.setName("bottomSensor");
    world.add(bottomSensor);
  }

  void act() {
    if (!die) {
      input();
      checkForDeadly();
    }

    checkForFall();
    deathTimer();
    animate();

    bottomSensor.setPosition(getX(), getY() + (gridSize / 2) + 1);
    bottomSensor.setVelocity(getVelocityX(), getVelocityY());
    
    //teleport
    if (rightkey == true) {
    setPosition(1300, 700);
    }
}

  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 7 == 0) {
      action[frame].resize(gridSize - 10, gridSize - 5);
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }

  void input() {
    float vx = getVelocityX();
    float vy = getVelocityY();

    if (abs(vy) < 1) {
      action = idle;
    }

    if (akey) {
      this.setVelocity(-125, vy);
      action = run;
      direction = L;
    }
    if (dkey) {
      this.setVelocity(125, vy);
      action = run;
      direction = R;
    }

    if (spacekey) {
      addImpulse(0, jumpImpulse);
    }

    if (wkey) {
      if (sTouching(bottomSensor, "floor") && !jumping) {
        jumping = true;
        jumpStartFrame = frameCount;
        //println("Jump started");
      }

      if (jumping && (frameCount - jumpStartFrame) < maxJumpFrames) {
        addImpulse(0, jumpImpulse);
      }
    } else {
      jumping = false;
    }

    if (abs(vy) > 30) {
      action = jump;
    }

    if (isTouching("floor") && abs(vx) < 0.1) action = idle;
  }

  void checkForFall() { //player out of map?
    if (this.getY() >= 1800) {
      fall = true;
    }

    if (fall) { //fall out of the map
      this.setPosition(0, 400);
      this.setVelocity(0, 1000);
      fall = false;
      falling = false;
    }

    if (this.getY() > 850 && !falling && !die) {
      cameraX = this.getX();
      cameraY = this.getY();
      falling = true;
      //if player falling, get x,y coordinates
    }

    if (falling) { //set x velocity 0 for camera
      this.setVelocity(0, this.getVelocityY());
    }
  }

  void checkForDeadly() { //player touching deadly block?
    if (sTouching(bottomSensor, "spike") || isTouching("thwomp") || sTouching(bottomSensor, "lava") || isTouching("hammer")) {
      this.setSensor(true);
      die = true;
      deathStartFrame = frameCount;
      this.setVelocity(0, -400);
    }
  }

  void deathTimer() { //wait before set die false
    if (die) {
      setAngularVelocity(30);

      if (deathStartFrame == frameCount) {
        cameraX = this.getX();
        cameraY = this.getY();
      }

      if (frameCount >= deathStartFrame + dieWaitFrames) {
        die = false;
        this.setSensor(false);
        this.setPosition(0, 400);
        this.setVelocity(0, 1000);
        setAngularVelocity(0);
        setRotation(0);
        fall = false;
        falling = false;
      }
    }
  }

  boolean isOnGround() {
    return abs(this.getVelocityY()) < 0.5;
  }
}
