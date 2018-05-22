/**
 * Brightness
 * by Daniel Shiffman. 
 * 
 * This program adjusts the brightness of a part of the image by
 * calculating the distance of each pixel to the mouse.
 
 
 */

import processing.video.*;

Capture cap;

PImage img;

void setup() {
  size(640, 480);
  frameRate(30);
  img = loadImage("moon-wide.jpg");
  cap = new Capture(this, 640, 480);
  cap.start();
  cap.loadPixels();
  // Only need to load the pixels[] array once, because we're only
  // manipulating pixels[] inside draw(), not drawing shapes.
  loadPixels();
}

void captureEvent(Capture cap) {
  if (cap.available()) {
    cap.read();
  }
}

void draw() {
  for (int x = 0; x < cap.width - 1; x++) {
    for (int y = 0; y < cap.height - 1; y++ ) {
      // Calculate the 1D location from a 2D grid
      int loc = x + y*cap.width;
      // Get the R,G,B values from image
      float r, g, b;
      r = red (cap.pixels[loc]);
      //g = green (img.pixels[loc]);
      //b = blue (img.pixels[loc]);
      // Calculate an amount to change brightness based on proximity to the mouse
      float maxdist = 90;//dist(0,0,width,height);
      float d = dist(x, y, mouseX, mouseY);
      float adjustbrightness = 255*(maxdist-d)/maxdist;
      r += adjustbrightness;
      //g += adjustbrightness;
      //b += adjustbrightness;
      // Constrain RGB to make sure they are within 0-255 color range
      r = constrain(r, 0, 255);
      //g = constrain(g, 0, 255);
      //b = constrain(b, 0, 255);
      // Make a new color and set pixel in the window
      //color c = color(r, g, b);
      color c = color(r);
      pixels[y*width + x] = c;
    }
  }
  updatePixels();
}