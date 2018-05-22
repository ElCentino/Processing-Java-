import processing.video.*;

float dist;
int closestX, closestY;
int motionX, motionY, count;
float threshood = 0;
PImage prev, pic;

float lerpX, lerpY;

float speed = 5f;

Capture video;

void setup() {
  size(1280, 720);
  video = new Capture(this, 640, 480, 30);
  video.start();

  prev = createImage(640, 480, RGB);
  
  printArray(Capture.list());
}

void mousePressed() {
}

void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  
  video.read();
}

void draw() {

  video.loadPixels();
  prev.loadPixels();
  
  background(255);
  image(video, 640, 0, width/2, height);

  threshood = 80;
  motionX = 0;
  motionY = 0;
  count = 0;

  //loadPixels();

  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {

      int loc = x + y * video.width;
      color capture = video.pixels[loc];
      color prevColor = prev.pixels[loc];

      float r1 = red(capture);
      float g1 = green(capture);
      float b1 = blue(capture);     
      float r2 = red(prevColor);
      float g2 = green(prevColor);
      float b2 = blue(prevColor);

      dist = dist(r1, g1, b1, r2, g2, b2);

      threshood = 80;

      if (dist > threshood) {        
        motionX = motionX + x;
        motionY = motionY + y;
        count++;
        //pixels[loc] = color(0);
      } else {
        //pixels[loc] = color(r1, g1, b1);
      }
    }

    updatePixels();
    prev.updatePixels();
  }

  if (count > 100) {
    motionX = motionX / count;
    motionY = motionY / count;
    println("Movement Detected");
  }

  lerpX = lerp(lerpX, motionX, 0.1 * speed);
  lerpY = lerp(lerpY, motionY, 0.1 * speed);

  strokeWeight(2.0);
  fill(255, 0, 255, 50);

  ellipse(lerpX, lerpY, 32, 32);
  ellipse(lerpX, lerpY, 64, 64);

  //if(lerpX > video.width/ 2) {
  //  line(width, 0, lerpX, lerpY);
  //  line(0, height, lerpX, lerpY);
  //} else {   
  //  line(0, 0, lerpX, lerpY);
  //  line(width, height, lerpX, lerpY);
  //}

  //line(lerpX, lerpY, lerpX + 10, lerpY + 10);
  //line(lerpX, lerpY, lerpX - 10, lerpY - 10);
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1) + (z2 - z1) * (z2 - z1);
  return d;
}