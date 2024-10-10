color white = #ffffff;
color black = #000000;
color blue  = #96A5B7;

ArrayList<Mover> myMovers;
int n = 40;

void setup() {
  size(800, 800);
  myMovers = new ArrayList();

  for (int i = 0; i < n; i++) myMovers.add(new Mover());
}

void draw() {
  background(blue);
  for (int i = 0; i < myMovers.size(); i++) {
    Mover m = myMovers.get(i);
    m.act();
    m.showCircle();
    m.showConnections();

    if (m.alive == false) {
      myMovers.remove(i);
    }
  }
}

void mouseReleased() {
  //myMovers.add( new Mover(mouseX, mouseY));
}
