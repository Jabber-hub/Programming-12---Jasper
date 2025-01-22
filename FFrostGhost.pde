class FFrostPhantom extends FGameObject {
  float speed = 50;
  boolean phasing = false;
  int freezeDuration = 120;
  float offset;

  FFrostPhantom(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    //setStaticBody(false);
    setSensor(true);
    attachImage(frostBoo);
    setName("frostPhantom");
    setFillColor(color(100, 200, 255, 150));
    setNoStroke();
    offset = random(0, 180);
  }

  void act() {
    move();
    checkForPlayer();
  }

  void move() {
    //float newX = getX() + cos(radians(frameCount*0.5));
    //float newY = getY() + sin(radians(frameCount));
    float newX = getX() + cos(radians(frameCount + offset));
    float newY = getY() + sin(radians(frameCount + offset));
    setPosition(newX, newY);
    setStatic(true);
  }

  void checkForPlayer() {
    if (isTouching("player")) {
      freezePlayer();
    }
  }

  void freezePlayer() {
    player.setVelocity(0, 0);
    player.frozen = true;
    //delay(() -> player.frozen = false, freezeDuration);
  }
}
