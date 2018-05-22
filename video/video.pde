import processing.video.*;

Capture r;

void setup() {
  size(640, 480);
  r = new Capture(this, 640, 480, 30); 
  r.start();

  printArray(Capture.list());
}

void mousePressed() {
  if (Capture.list().length == 0) {
    print("No Suitable Devices found");
  } else {
    //r.read();
  }
}

void captureEvent(Capture r) {
  if (r.available()) {
    r.read();
  }
}

void draw() {
  normalCapture();
  //edgeDetection();
  //Pixilate();

  //reverseCapture();
}

void Pixilate() {

  for (int i = 0; i <2000; i++) {
    int x = (int)random(width);
    int y = (int)random(height);

    float red = red(r.get(x, y));
    float green = green(r.get(x, y));
    float blue = blue(r.get(x, y));

    noStroke();
    fill(color(red, green, blue));

    ellipse(x, y, 1, 1);
  }
}

void edgeDetection() {
  r.loadPixels();
  loadPixels();
  for (int x = r.width; x > 0; x--) {
    for (int y = r.height; y > 0; y--) {

      int loc = x + (y * r.width);
      int locA = (x + 1) + (y * r.width + 1);

      float red = red(r.pixels[loc]);
      float green = green(r.pixels[loc]);
      float blue = blue(r.pixels[loc]);

      float diffA = brightness(r.pixels[loc]);
      float diffB = brightness(r.pixels[locA]);

      float diff = diffB - diffA;

      int treshood = (int) map(mouseX, 0, width, 0, 10);

      if (diff > treshood) {
        pixels[loc] = color(red, green, blue);
      } else {
        pixels[loc] = color(255);
      }
    }
  }

  updatePixels();
}

void normalCapture() {
  image(r, 0, 0, width, height);
}

void reverseCapture() {
  r.loadPixels();
  loadPixels();
  for (int x = r.width - 1; x > 0; x--) {
    for (int y = r.height - 1; y > 0; y--) {

      int loc = x + y * r.width;

      float red = red(r.pixels[loc]);
      float green = green(r.pixels[loc]);
      float blue = blue(r.pixels[loc]);

      float bright = brightness(color(red, green, blue));
      
      float white = color(255);
      
      float dist = bright - white;


      if (dist < map(mouseX, 0, width, 0, map(mouseY, 0, height, 0, 255))) {
        pixels[loc] = color(red(r.pixels[loc]), green(r.pixels[loc]), blue(r.pixels[loc]));
      } else {
        pixels[loc] = color(255);
      }
    }
  }

  updatePixels();
}