import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 
import java.util.Collections; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Enhanced_Motion_Detector_Algorithm extends PApplet {




Capture video;

PImage prev;

float distance = 0;
float threshold = 200;
boolean groupDetected = false;

int counter = 0;

ArrayList<Group> groups = new ArrayList<Group>();

public void setup() {

  

  video = new Capture(this, 640, 480, 30);
  video.start();

  prev = createImage(640, 480, RGB);
}

public void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  video.read();
}

public void draw() {

  groups.clear();

  video.loadPixels();
  prev.loadPixels();

  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {

      int loc = x + y * video.width;

      int current = video.pixels[loc];
      float r1 = red(current);
      float g1 = green(current);
      float b1 = blue(current);

      int previous = prev.pixels[loc];
      float r2 = red(previous);
      float g2 = green(previous);
      float b2 = blue(previous);

      distance = distanceSq(r1, g1, b1, r2, g2, b2);

      if (distance > threshold * threshold) {

        groupDetected = false;

        for (Group group : groups) {
          if (group.isNear(x, y)) {
            group.addPoint(x, y);
            groupDetected = true;
            break;
          }
        }

        if (!groupDetected) {
          Group g = new Group(x, y);
          if (groups.size() < 1000) {
            groups.add(g);
          }
        }
      }
    }
  }



  image(video, 0, 0, width, height);

  chooseLargest(groups);

  counter = 0;
}

public float distanceSq(float r1, float g1, float b1, float r2, float g2, float b2) {
  return ((r2 - r1) * (r2 - r1)) + ((g2 - g1) * (g2 - g1)) + ((b2 - b1) * (b2 - b1));
}

public float distanceSq(float x1, float y1, float x2, float y2) {
  return ((x2 - x1) * (x2 - x1)) + ((y2 - y1) * (y2 - y1));
}

public void chooseLargest(ArrayList<Group> groups) {

  ArrayList<Float> sizes = new ArrayList<Float>();

  for (Group group : groups) {
    sizes.add(group.getComputedPixels());
    Collections.sort(sizes);
  }

  if (!groups.isEmpty()) {
    
    float x =  groups.get(sizes.size() -1).startingPointX;
    float y =  groups.get(sizes.size() -1).startingPointY;
    float w = groups.get(sizes.size() -1).startingWidth;
    float h = groups.get(sizes.size() -1).startingHeight;
    
    println("X : " + x);
    println("Y : " + y);
    println("Width : " + w);
    println("Height : " + h);

    fill(0, 20);
    strokeWeight(2);
    rectMode(CENTER);
    rect(x, y, w, h);
    
    text("Weight detected ", x, y);
  } 

  sizes.clear();
}


float pixelThreshold = 10;

class Group {

  float startingPointX;
  float startingPointY;
  float startingWidth;
  float startingHeight;

  Group(float x, float y) {
    startingPointX = x;
    startingPointY = y;
    startingWidth = x;
    startingHeight = y;
  }

  public void addPoint(float x, float y) {
    startingWidth = max(startingWidth, x);
    startingHeight = max(startingHeight, y);
    startingPointX = min(startingPointX, x);
    startingPointY = min(startingPointY, y);
  }
  
  public float getComputedPixels() {
   float pixelsX = startingWidth - startingPointX;
   float pixelsY = startingHeight - startingPointY;
   
   float totalPixels = pixelsX * pixelsY;
   
   return totalPixels;
  }

  public boolean isNear(float x, float y) {

    float cx = (startingWidth + startingPointX) / 2;
    float cy = (startingHeight + startingPointY) / 2;

    float dist = distanceSq(cx, cy, x, y);

    if (dist < pixelThreshold * pixelThreshold) {
      return true;
    } else {
      return false;
    }
  }
  
  public void show() {
   fill(255, 0, 0);
   stroke(0);
   
   ellipse(startingPointX, startingPointY, startingWidth, startingHeight); 
  }
}
  public void settings() {  size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Enhanced_Motion_Detector_Algorithm" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
