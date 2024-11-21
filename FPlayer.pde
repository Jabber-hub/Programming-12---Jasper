class FPlayer extends FBox {
  FPlayer() {
    super(gridSize-5, gridSize-5);
    setPosition(300, 500);
    setFillColor(red);
    setRotatable(false);
  }

  void act() {
    //horizontal movement
    if (akey) {
      this.setVelocity(-150, this.getVelocityY());
    } else if (dkey) {
      this.setVelocity(150, this.getVelocityY());
    } 

    // jumping
    if ((wkey) && isOnGround()) {
      this.addImpulse(0, -800);
    }
  }

  // ground detection
  boolean isOnGround() {
    return abs(this.getVelocityY()) < 0.5;
  }
}
