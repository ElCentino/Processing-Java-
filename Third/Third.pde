import gab.opencv.*;

import processing.video.*;


PImage pic, pic2;

float r, g, b;

Capture video;

void setup() {

  pic = loadImage("C:\\Users\\Saryn\\Desktop\\download.png");

  size(640, 480);
  
  video = new Capture(this, 640, 480);
  video.start();
  
  printArray(Capture.list());
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  
  background(5);
  
  loadPixels();
  
  for (int x = 0; x < video.width; x++) {
    
    for (int y = 0; y < video.height; y++) {
      
      int loc = x + y * video.width;
      
      float red = red(video.pixels[loc]);
      float green = green(video.pixels[loc]);
      float blue = blue(video.pixels[loc]);

      float d = dist(mouseX, mouseY, x, y);
      
      float fac = map(d, 0, 200, 2, 0);
      
      color b = color(red / fac /2 , green / fac /2, blue / fac /2);
      
      pixels[loc] = b;
    }
  }
  
  updatePixels();

  //println(frameRate);
}

void mousePressed() {
  r = random(217);
  g = random(255);
  b = random(255);
}