color blue   = #28e7ed;
color green  = #338B2C;
color pink   = #f76ddc;
color yellow = #fff387;
color black  = #000000;
color white  = #ffffff;

boolean mouseReleased;
boolean wasPressed;


Button[] myButtons;


void setup (){
  size(600, 600);
  myButtons = new Button[4];
  myButtons[0] = new Button("black", 450, 300, 100, 100, black, white);
  myButtons[1] = new Button("green", 300, 100, 500, 200, green, blue);
  myButtons[2] = new Button("pink", 150, 300, 150, 150, pink, yellow);
  myButtons[3] = new Button("white", 300, 500, 500, 200, white, black);
}

void draw (){
  click();
  for(int i = 0; i < 4; i++) {
  myButtons[i].show();
  }
  
  //if (myButtons[0].clicked) {
  //background();
  //}
}
