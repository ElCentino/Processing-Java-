
void setup() {
  size(700, 400);
}

float angle = 0;
float dl = 0.7f;

void draw() {
  background(51);

  stroke(255);
  translate(width / 2, height);
  
  
  branch(100);
  angle = constrain(0, mouseX, PI / 4) * 0.05;
}

void branch(float len) {
  line(0, 0, 0, - len);
  translate(0, -len);


  if (len > 4) {
    pushMatrix();
    rotate(angle);
    branch(len * dl);
    popMatrix();
    pushMatrix();
    rotate(-angle);
    branch(len * dl);
    popMatrix();
  }
}