class FHammerBro extends FGameObject {

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

  FHammerBro(float x, float y) {
    super(gridSize - 15, gridSize - 5);
    setPosition(x, y);
    setRestitution(0.4);
    setRotatable(false);
    setName("hammerBro");
  }

  void act() {
    animate();
    move();
    collide();
    throwHammers();
  }

  void animate() {
    if (frame >= goomba.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(hammerbro[frame]);
      if (direction == L) attachImage(reverseImage(hammerbro[frame]));
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
    if (isTouching("player") ) {
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
  void throwHammers() {
    if (frameCount % 150 == 0 && !isSensor()) {
    FGameObject hammer = new FGameObject(20, 20);
    hammer.setPosition(getX(), getY());
    hammer.setVelocity(random(150, 250)*direction, -random(400, 600));
    hammer.setAngularVelocity(random(20, 50)*direction);
    hammer.setSensor(true);
    hammer.setRestitution(1);
    hammer.attachImage(Hammer);
    hammer.setName("hammer");
    world.add(hammer);
    }
  }
}
