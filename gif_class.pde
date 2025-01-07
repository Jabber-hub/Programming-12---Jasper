class gif {
  // Instance variables
  PImage[] frames;
  int numFrames;
  int speed;
  int currentFrame;
  float x, y;
  int w, h;

  // Constructor 1
  gif(String b, String a, int n, int s, int _x, int _y) {
    frames = new PImage[n];
    numFrames = n;
    speed = s;
    currentFrame = 0;
    x = _x;
    y = _y;

    
    for (int i = 0; i < numFrames; i++) {
      frames[i] = loadImage(b + i + a);
    }
    
    w = frames[0].width;
    h = frames[0].height;
  }

  // Constructor 2 (with width and height adjustments)
  gif(String b, String a, int n, int s, int _x, int _y, int _w, int _h) {
    this(b, a, n, s, _x, _y);  // Call first constructor
    w = _w;
    h = _h;
    
    for (int i = 0; i < numFrames; i++) {
      frames[i].resize(w, h);
    }
    
  }

  void show() {
    if (currentFrame == numFrames) currentFrame = 0;
    image(frames[currentFrame], x, y);
    if (frameCount % speed == 0) currentFrame++;
  }
}
