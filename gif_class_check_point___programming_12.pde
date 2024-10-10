gif octopus, goose;

void setup() {
size(800, 600);
octopus = new gif("octopus/frame_", "_delay-0.04s.gif", 45, 3, 0, 0, width, height);
goose = new gif("goose/frame_", "_delay-0.04s.gif", 15, 2, 600, 0, 200, 250);
}

void draw() {
octopus.show();
goose.show();
}
