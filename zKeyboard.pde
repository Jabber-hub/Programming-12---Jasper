void keyPressed() {
  if (key == 'w' || key == 'W') wkey = true;
  if (key == 'a' || key == 'A') akey = true;
  if (key == 's' || key == 'S') skey = true;
  if (key == 'd' || key == 'D') dkey = true;
  if (keyCode == UP)            upkey = true;
  if (keyCode == DOWN)          downkey = true;
  if (keyCode == LEFT)          leftkey = true;
  if (keyCode == RIGHT)         rightkey = true;
  if (key == ' ')               spacekey = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') wkey = false;
  if (key == 'a' || key == 'A') akey = false;
  if (key == 's' || key == 'S') skey = false;
  if (key == 'd' || key == 'D') dkey = false;
  if (keyCode == UP) {
    upkey = false;
    //FGoomba gmb = new FGoomba(player.getX() + (mouseX-width/2)/zoom, player.getY() + (mouseY-width/2)/zoom);
    //println(mouseX-width/2, mouseY-width/2);
    //enemies.add(gmb);
    //world.add(gmb);
  }
  if (keyCode == DOWN) {
    downkey = false;
    //FHammerBro hb = new FHammerBro(player.getX() + (mouseX-width/2)/zoom, player.getY() + (mouseY-width/2)/zoom);
    //println(mouseX-width/2, mouseY-width/2);
    //enemies.add(hb);
    //world.add(hb);
  }
  if (keyCode == LEFT) leftkey = false;
  if (keyCode == RIGHT) rightkey = false;
  if (key == ' ') spacekey = false;
}
