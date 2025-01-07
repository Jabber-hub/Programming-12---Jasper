class Button {

  //instance variables
  int x, y, w, h;
  boolean clicked, hovering;
  color highlight, normal;
  String text;
  PImage img;

  //constructor for TEXT
  Button(String t, int _x, int _y, int _w, int _h, color norm, color high) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    text = t;
    highlight = high;
    normal = norm;
    clicked = false;
    hovering = false;
    img = null;
  }
  
  //constructor for IMAGES
  Button(PImage _img, int _x, int _y, int _w, int _h, color norm, color high) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    text = "";
    highlight = high;
    normal = norm;
    clicked = false;
    hovering = false;
    img = _img;
  }

  void show() {
    checkForHover();
    drawRect();
    drawContent();
    checkForClicked();

  }

  void checkForHover() {
  if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) {
      hovering = true;
    } else {
      hovering = false;
    }
  }
  
  void drawRect() {
    rectMode(CENTER);
    if (hovering) {
      fill(highlight);
    } else {
      fill(normal);
    }
    stroke(0);
    strokeWeight(4);
    rect(x, y, w, h, 30);
  }

  void drawContent() {
    if (img != null) {
      imageMode(CENTER);
      image(img, x, y, w, h);
    } else {
      textAlign(CENTER, CENTER);
      if (hovering) {
        fill(normal);
      } else {
        fill(highlight);
      }
      textSize(w / 4);
      text(text, x, y);
    }
  }

  void checkForClicked() {
    if (mouseReleased && hovering) {
      clicked = true;
    } else {
      clicked = false;
    }
  }
}
