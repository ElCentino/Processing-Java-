
private Ball b;

void setup() {
  size(600, 400);
  background(255);
  
  
}
void start() {
  b = new Ball(width/2, -100, 34);
  
}

void draw() {
  
  background(255);
  translate(0, height);
  b.spawnBall(color(170, 43, 255));
  b.detectCollision();
}