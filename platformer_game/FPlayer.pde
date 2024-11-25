class FPlayer extends FGameObject {
    boolean falling = false;
    boolean fall = false;
    boolean die = false;
    int deathStartFrame = -1;
    int dieWaitFrames = 160;

    FPlayer() {
        super(gridSize-5, gridSize-5); 
        setPosition(0, 400); 
        setName("player"); 
        setFillColor(color(255, 0, 0));
        setRotatable(false);
    }

    void act() {
        if (!die) {
            handleInput();
            checkForSpike();
        }
        
        checkForFall();
        handleDeathTimer();
    }

    void handleInput() {
        
        if (akey) {
            this.setVelocity(-150, this.getVelocityY());
        } else if (dkey) {
            this.setVelocity(150, this.getVelocityY());
        }

        
        if (wkey && isOnGround()) {
            this.addImpulse(0, -850);
        }
    }

    void checkForFall() { //player out of map?
        if (this.getY() >= 2000) {
            fall = true;
        }

        if (fall) { //fall out of the map
            this.setPosition(0, 400); 
            this.setVelocity(0, 1000); 
            fall = false;
            falling = false;
        }

        if (this.getY() > 800 && !falling && !die) {
            cameraX = this.getX();
            cameraY = this.getY();
            falling = true;
            //if player falling, get x,y coordinates
        }

        if (falling) { //set x velocity 0 for camera
            this.setVelocity(0, this.getVelocityY());
        }
    }

    void checkForSpike() { //player touching spike?
        if (isTouching("spike")) {
          this.setSensor(true);
            die = true;
            deathStartFrame = frameCount;
            this.setVelocity(0, -400);
        }
    }

    void handleDeathTimer() { //wait before set die false
        if (die) {
            

            if (deathStartFrame == frameCount) {
                cameraX = this.getX();
                cameraY = this.getY();
            }

            if (frameCount >= deathStartFrame + dieWaitFrames) {
                die = false;
                this.setSensor(false);
                this.setPosition(0, 400);
                this.setVelocity(0, 0);
                fall = false;
                falling = false;
            }
        }
    }

    boolean isOnGround() {
        return abs(this.getVelocityY()) < 0.5;
    }
}
