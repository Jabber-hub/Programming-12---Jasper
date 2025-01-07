class FLava extends FGameObject {
  int frame = 0;
  float delay = random(20, 100);
  int lastUpdateTime = 0;

  FLava(float x, float y) {
    super(gridSize, gridSize - 30);
    setPosition(x, y);
    setName("lava");
    attachImage(lavaImages.get(0));
    setStatic(true);
  }

  void act() {
    if (isTouching("player")) {
      println("touching lava");
    }

    if (frameCount - lastUpdateTime >= delay) {
      lastUpdateTime = frameCount;
      frame = (frame + 1) % lavaImages.size();
      attachImage(lavaImages.get(frame));
    }
  }
}
