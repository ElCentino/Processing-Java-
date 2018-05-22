
import processing.video.*;
import java.util.Collections;

Movie video;

PImage prev;

float distance = 0;
float threshold = 90;
float computedPixels = 100;
boolean groupDetected = false;

int counter = 0;
int count = 0;
int motionDetected = 0;

float avgX = 0;
float avgY = 0;
float avgComputedPixels = 0;

ArrayList<Group> groups = new ArrayList<Group>();

int W = 1280;
int H = 720;

void setup() {

  size(720, 480);
  
  prev = createImage(720, 480, RGB);
  
  video = new Movie(this, "street.mov");
  video.loop();
  
}

void movieEvent(Movie video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void draw() {

  image(video, 0, 0); 
  trackVideo();
}

float distanceSq(float r1, float g1, float b1, float r2, float g2, float b2) {
  return ((r2 - r1) * (r2 - r1)) + ((g2 - g1) * (g2 - g1)) + ((b2 - b1) * (b2 - b1));
}

float distanceSq(float x1, float y1, float x2, float y2) {
  return ((x2 - x1) * (x2 - x1)) + ((y2 - y1) * (y2 - y1));
}

void chooseLargest(ArrayList<Group> groups) {

  count = 0;

  avgX = 0;
  avgY = 0;
  count = 0;
  avgComputedPixels = 0;

  for (Group group : groups) {

    if (group.getComputedPixels() > computedPixels) {
      count++;
      group.show();

      avgX += group.startingPointX;
      avgY += group.startingPointY;
    }
  }

  avgX = avgX / count;
  avgY = avgY / count;

  avgComputedPixels = avgX * avgY;

  if (!groups.isEmpty()) {

    fill(0);
    textSize(15);
    text("Total Blobs : " + count, 5, 20);
  } 

  text("Threshold : " + (int)threshold, 5, 40);
  text("Pixel Threshold : " + (int)pixelThreshold, 5, 60);
  text("Motion Detected : " + (int)motionDetected, 5, 80);
}

void trackVideo() 
{
  groups.clear();

  video.loadPixels();
  prev.loadPixels();

  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {

      int loc = x + y * video.width;

      color current = video.pixels[loc];
      float r1 = red(current);
      float g1 = green(current);
      float b1 = blue(current);

      color previous = prev.pixels[loc];
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
          groups.add(g);
        }

        motionDetected++;
      }
    }
  }

  chooseLargest(groups);

  counter = 0;
}