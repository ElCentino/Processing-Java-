
class Ball {

  private float x;
  private float y;
  private float diameter;
  private float dx = 1;
  private float dy = 1;
  private float dt = 1.5;

  private float gravity = 10f;

  public Ball(float x, float y, float diameter) {

    this.x = x;
    this.y = y;
    this.diameter = diameter;
  }

  void spawnBall(color ballColor) {
    fill(ballColor);
    stroke(ballColor);
    ellipse(x, y, diameter, diameter);
  }

  public void detectCollision() {
    //moveBall();

    bounce();

    if (x > width - diameter/2 || x < 0 + diameter/2) {
      dx *= -1;
      dt += 0.1;
    }

    if (y > 0 - diameter/2 || y < -height + diameter/2) {
      dy *= -1; 
      dt += 0.1;
    }
  }

  private void moveBall() {

    x += dx * dt;
    y += dy * dt;
  }
  private void bounce() {
    
    if (y <= gravity) {
      
      if(y > 0 - diameter/2) {
        y = 0 - diameter/2;
      }
      
      y++;
    }
  }
  
  void keyPressed() {
    if(keyCode == 'A') {
      moveBall();
    }
  }
}