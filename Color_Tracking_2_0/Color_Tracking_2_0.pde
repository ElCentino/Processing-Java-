import processing.video.*;

float worldRecord = 500;
float dist;
color tracker;
int closestX, closestY;
int avgX, avgY, count;
float threshood = 25;
float lerpX, lerpY;
float speed = 5f;

Capture video;

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480, 30);
  video.start();

  tracker = color(209, 187, 183);
}

void mousePressed() {
  tracker = video.get(mouseX, mouseY);
  print(red(tracker)+":"+ green(tracker) + ":" + blue(tracker));
}

void captureEvent(Capture video) {
  if (video.available()) {
    video.read();
  }
}

void draw() {
  
  if(keyCode == 'Z') {
    image(video, 0, 0);
  } else if(keyCode == 'X') {
    background(255, 255, 255);
  }

  rectMode(CENTER);

  video.loadPixels();

  worldRecord = 500;
  closestX = 0;
  closestY = 0;

  avgX = 0;
  avgY = 0;
  count = 0;

  threshood = map(mouseX, 0, video.width, 0, 100);
  threshood = 6;

  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {

      int loc = x + y * video.width;

      color capture = video.pixels[loc];

      float r1 = red(capture);
      float g1 = green(capture);
      float b1 = blue(capture);
      float r2 = red(tracker);
      float g2 = green(tracker);
      float b2 = blue(tracker);

      dist = distSq(r1, g1, b1, r2, g2, b2);
      
      threshood = map(mouseX, 0, width, 0, 255);
      threshood = 100;

      if (dist < threshood * threshood) {
        avgX = avgX + x;
        avgY = avgY + y;

        stroke(255, 0, 255);
        count++;
      }
    }
  }

  if (count > 0) {

    avgX = avgX / count;
    avgY = avgY / count;

    lerpX = lerp(lerpX, avgX, 0.1f * speed);
    lerpY = lerp(lerpY, avgY, 0.1f * speed);

    strokeWeight(32.0);
    fill(tracker);

    point(lerpX, lerpY);
    //ellipse(lerpX, lerpY, 64, 64);

    //if (lerpX > video.width/ 2) {
    //  line(width, 0, lerpX, lerpY);
    //  line(0, height, lerpX, lerpY);
    //} else {   
    //  line(0, 0, lerpX, lerpY);
    //  line(width, height, lerpX, lerpY);
    //}

    //line(lerpX, lerpY, lerpX + 10, lerpY + 10);
    //line(lerpX, lerpY, lerpX - 10, lerpY - 10);
  }
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1) + (z2 - z1) * (z2 - z1);
  return d;
}