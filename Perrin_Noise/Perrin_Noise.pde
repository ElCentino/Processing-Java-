int w = 1200;
int h = 900;

float[][] terrain;
float[][] terrain2;

float flying = 0;
float flying2 = 0;

void setup() {

  size(600, 600, P3D);


  col = w / scl;
  row = h / scl;

  terrain = new float[col][row];
  terrain2 = new float[col][row];


}

int col, row;

int scl = 20;

void draw() {
  
  flying -= random(0.02, 0.01);
  
  float yoff = 0;
  for (int y = 0; y < row; y++) {
    float xoff = flying;
    for (int x = 0; x < col; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -80, 80);
      xoff += 0.2;
    }
    
    yoff += 0.2;
  }
  
  flying2 -= random(0.02, 0.01);
  
  float yoff2 = 0;
  for (int y = 0; y < row; y++) {
    float xoff = flying2;
    for (int x = 0; x < col; x++) {
      terrain2[x][y] = map(noise(xoff, yoff2), 0, 1, -80, 80);
      xoff += 0.22;
    }
    
    yoff2 += 0.22;
  }


  background(0);

  stroke(0);
  fill(0, 60, 255, 100);

  translate(width/2, height/2);

  rotateX(PI/3);
  
  pushMatrix();

  translate(-w/2, -h/2);

  for (int y = 0; y < row - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < col; x++) {
      vertex(x * scl, y * scl, terrain[x][y]);
      vertex(x * scl, (y + 1) * scl, terrain[x][y+1]);
    }

    endShape();
  }
  
  popMatrix();
  
  pushMatrix();
  
  translate(-w/2 + 400, -h/2);
  
  fill(0, 60, 255, 200);
  
  for (int y = 0; y < row - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < col; x++) {
      vertex(x * scl, y * scl, terrain2[x][y]);
      vertex(x * scl, (y + 1) * scl, terrain2[x][y+1]);
    }

    endShape();
  }
  
  popMatrix();
}