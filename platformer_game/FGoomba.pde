class FGoomba extends FGameObject {

  float vx = 40;
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
    setRestitution(1);
    setRotatable(false);
    setName("goomba");
  }

  void act() {
    if (!die) {
      setVelocity(vx * direction, 0);

      if (isTouching("wall") && frameCount > lastWallCollisionFrame + wallCooldownFrames) {
        direction *= -1;
        lastWallCollisionFrame = frameCount;
      }
      if (frameCount - lastUpdateTime >= delay) {
        lastUpdateTime = frameCount;
        frame = (frame + 1) % 2;
        attachImage(goomba[frame]);
      }
      if (sTouching(this, ("bottomSensor")) && player.getY() - getY() < -gridSize/1.1) {
        die = true;
        player.setVelocity(player.getVelocityX(), -200);
        setPosition(getX(), getY()-10);
      }
    }  if (die == true) {
      setVelocity(0, getVelocityY());
      setSensor(true);
    }
  }
}
