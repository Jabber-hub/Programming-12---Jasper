class FPlayer extends FBox {

  boolean falling = false;
  boolean fall = false;
  boolean die = false;
  int deathStartFrame = -1;
  int dieWaitFrames = 160;

  FPlayer() {
    super(gridSize - 5, gridSize - 5);
    setPosition(0, 400);
    setFillColor(red);
    setRotatable(false);
  }

  void act() {
    if (!die) {
      handleInput();
    }

    checkForCollisions();
    checkForFall();
    handleDeathTimer();
  }

  void handleInput() {
    // Horizontal movement
    if (akey) {
      this.setVelocity(-150, this.getVelocityY());
    } else if (dkey) {
      this.setVelocity(150, this.getVelocityY());
    }

    // Jumping
    if (wkey && isOnGround()) {
      this.addImpulse(0, -850);
    }
  }

  void checkForFall() {
    if (this.getY() >= 2000) {
      fall = true;
    }

    if (fall) {
      this.setPosition(0, 400);
      this.setVelocity(0, 1000);
      fall = false;
      falling = false;
    }
    
    if (this.getY() > 800) {
    cameraX = this.getX();
    cameraY = this.getY();
    falling = true;
    }
    
    if(falling) {
    this.setVelocity(0, this.getVelocityY());
    }
  }

  void checkForCollisions() {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains("spike")) {
        if (!die) {
          die = true;
          deathStartFrame = frameCount;
          this.setVelocity(0, -400);
        }
      }
    }
  }


  void handleDeathTimer() {
    if (die) {
      this.setSensor(true);

      // Save position of player when it dies
      if (deathStartFrame == frameCount) {
        cameraX = this.getX();
        cameraY = this.getY();
      }

      if (frameCount >= deathStartFrame + dieWaitFrames) {
        die = false;
        this.setSensor(false);
        
        this.setPosition(0,400);
        this.setVelocity(0,400);
        
        fall=false;
        falling=false;
      }
    }
  }

  // Ground detection
  boolean isOnGround() {
    return abs(this.getVelocityY()) < 0.5;
  }
}
