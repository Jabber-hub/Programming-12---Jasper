class Bullet extends GameObject {

  PVector dir;
  float speed;

  Bullet() {
    super(eyeX, eyeY, eyeZ, 10);
    speed = 50;
    float vx = cos(leftRightHeadAngle);
    float vy = tan(upDownHeadAngle);
    float vz = sin (leftRightHeadAngle);
    dir = new PVector(vx, vy, vz);
    dir.setMag(speed);
  }

  void act() {
    int hitX = int(loc.x+1500)/gridSize;
    int hitY = int(loc.z+2000)/gridSize;

    if (map.get(hitX, hitY) == white) {
      loc.add(dir);
    } else {
      lives = 0;
      snowball.rewind();
      snowball.play();
      for (int i = 0; i < 5; i++) {
        objects.add(new Particle(loc));
      }
    }
  }
}
