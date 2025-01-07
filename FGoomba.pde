class FGoomba extends FGameObject {

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

  FGoomba(float x, float y) {
    super(gridSize - 5, gridSize - 5);
    setPosition(x, y);
    setRestitution(0.4);
    setRotatable(false);
    setName("goomba");
  }

  void act() {
    animate();
    move();
    collide();
  }

  void animate() {
    if (frame >= goomba.length) frame = 0;
    if (frameCount % 5 == 0) {
      attachImage(goomba[frame]);
      frame++;
    }
  }

  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }

  void collide() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX()+direction*2, getY());
    }
    if (isTouching("player") && !player.isSensor()) {
      if (player.getY() < getY()-gridSize/1.5) {
        this.setVelocity(0, getVelocityY());
        Kill.rewind();
        Kill.play();
        if (!isSensor()) setPosition(getX(), getY()-1);

        this.setSensor(true);

        player.setVelocity(player.getVelocityX(), -150);
      } else {

        player.die = true;
        player.deathStartFrame = frameCount;
        player.setSensor(true);
      }
    }
  }
}
