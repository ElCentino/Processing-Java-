import processing.video.*;

Capture cap;

PImage prev;

float threshold = 80;

void setup() {
  size(640, 480);

  cap = new Capture(this, 640, 480, 30);
  cap.start();

  prev = createImage(640, 480, RGB);
}

void mousePressed() {
  prev.copy(cap, 0, 0, cap.width, cap.height, 0, 0, prev.width, prev.height);
  //cap.read();
}

void captureEvent(Capture cap) {
  cap.read();
}

void draw() {
  
  image(cap, 0, 0);
  cap.loadPixels();
  prev.loadPixels();

  //loadPixels();

  float distance = 0;
  float counter = 0;
  
  float avX = 0;
  float avY = 0;

  float vX = 0;
  float vY = 0;

  for (int x = 0; x < cap.width; x++) {
    for (int y = 0; y < cap.height; y++) {

      int loc = x + y * cap.width;
      color currentCol = cap.pixels[loc];
      color difference = prev.pixels[loc];

      float r1 = red(currentCol);
      float g1 = green(currentCol);
      float b1 = blue(currentCol);

      float r2 = red(difference);
      float g2 = green(difference);
      float b2 = blue(difference);

      distance = distSq(r1, g1, b1, r2, g2, b2);

      if (distance > threshold * threshold) {
        //pixels[loc] = color(r1, g1, b1);
        vX += x;
        vY += y;
        counter++;
      } else {
        //pixels[loc] = color(r2, g2, b2);
      }
    }
  }

  float rthreshold = 20;
  if (distance > rthreshold * rthreshold) {
    println("Not Close Enough");
  } else {
    println("Close");
  }
  
  

  if (counter > 2000) {
    avX = vX / counter;
    avY = vY / counter;
  }

  stroke(0);
  fill(255, 0, 0);
  ellipse(avX, avY, 30, 30);

  //updatePixels();
}

float distSq(float r1, float g1, float b1, float r2, float g2, float b2) {
  return pow((r2 - r1), 2) + pow((g2 - g1), 2) + pow((b2 - b1), 2);
}