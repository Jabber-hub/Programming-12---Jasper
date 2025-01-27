void drawFocalPoint() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  sphere(5);
  popMatrix();
}

void controlCamera() {

  if (wkey && canMoveForward()) {
    eyeX = eyeX + cos(leftRightHeadAngle)*10;
    eyeZ = eyeZ + sin(leftRightHeadAngle)*10;
  }
  if (skey && canMoveBack()) {
    eyeX = eyeX - cos(leftRightHeadAngle)*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle)*10;
  }
  if (akey && canMoveLeft()) {
    eyeX = eyeX + cos(leftRightHeadAngle-radians(90))*10;
    eyeZ = eyeZ + sin(leftRightHeadAngle-radians(90))*10;
  }
  if (dkey && canMoveRight()) {
    eyeX = eyeX - cos(leftRightHeadAngle-radians(90))*10;
    eyeZ = eyeZ - sin(leftRightHeadAngle-radians(90))*10;
  }

  leftRightHeadAngle = leftRightHeadAngle + (mouseX - pmouseX)*0.01;
  upDownHeadAngle = upDownHeadAngle + (mouseY - pmouseY)*0.01;
  if (upDownHeadAngle > PI/2.5) upDownHeadAngle = PI/2.5;
  if (upDownHeadAngle > -PI/2.5) upDownHeadAngle = -PI/2.5;

  focusX = eyeX + cos(leftRightHeadAngle)*300;
  focusZ = eyeZ + sin(leftRightHeadAngle)*300;
  focusY = eyeY + tan(upDownHeadAngle)*300;

  //wrapMouse();
  //rbt.mouseMove(width/2, height/2);
}

boolean canMoveForward() {
  float fwdX, fwdZ;
  int mapX, mapY;

  fwdX = eyeX + cos(leftRightHeadAngle)*150;
  fwdZ = eyeZ + sin(leftRightHeadAngle)*150;

  mapX = int(fwdX+1500) / gridSize;
  mapY = int(fwdZ+2000) / gridSize;

  if (map.get(mapX, mapY) == white) {
    return true;
  } else {
    return false;
  }
}

boolean canMoveLeft() {
  float leftX, leftZ;
  int mapX, mapY;

  leftX = eyeX + cos(leftRightHeadAngle-radians(90))*150;
  leftZ = eyeZ + sin(leftRightHeadAngle-radians(90))*150;

  mapX = int(leftX+1500) / gridSize;
  mapY = int(leftZ+2000) / gridSize;

  if (map.get(mapX, mapY) == white) {
    return true;
  } else {
    return false;
  }
}

boolean canMoveRight() {
  float rightX, rightZ;
  int mapX, mapY;

  rightX = eyeX + cos(leftRightHeadAngle+radians(90))*150;
  rightZ = eyeZ + sin(leftRightHeadAngle+radians(90))*150;

  mapX = int(rightX+1500) / gridSize;
  mapY = int(rightZ+2000) / gridSize;

  if (map.get(mapX, mapY) == white) {
    return true;
  } else {
    return false;
  }
}

boolean canMoveBack() {
  float backX, backZ;
  int mapX, mapY;

  backX = eyeX - cos(leftRightHeadAngle)*150;
  backZ = eyeZ - sin(leftRightHeadAngle)*150;

  mapX = int(backX+1500) / gridSize;
  mapY = int(backZ+2000) / gridSize;

  if (map.get(mapX, mapY) == white) {
    return true;
  } else {
    return false;
  }
}

void shoot() {
if (spacekey) {
  Bullet myBullet = new Bullet();
objects.add(myBullet);
}
}
