class Particle extends GameObject {
  PVector velocity; 
  float lifespan;
  float size;

  Particle(PVector position) {
    super(position.x, position.y, position.z, 5); 
    velocity = PVector.random3D(); 
    velocity.mult(random(1, 5)); 
    lifespan = 255; 
    size = random(3, 6); 
  }

  void act() {
    loc.add(velocity); 
    lifespan -= 5; 
    if (lifespan <= 0) {
      lives = 0; 
    }
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    noStroke();
    fill(white, lifespan); // Fade effect
    box(size); 
    popMatrix();
    
    fill(white);
  }
}
