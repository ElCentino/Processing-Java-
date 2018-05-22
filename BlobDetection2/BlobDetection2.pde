import processing.video.*;

float dist;
float threshood = 0;
color target;

ArrayList<Blob> blobs = new ArrayList<Blob>();
ArrayList<Blob> closeBlobs = new ArrayList<Blob>();

public float relXPos, relYPos, avgX, avgY;

public float blobWidth = 1;
public float blobHeight = 1;

Capture video;

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480, 30);
  video.start();

  target = color(87, 86, 255);
}

void mousePressed() {
  target = video.get(mouseX, mouseY);
  print(red(target)+":"+ green(target) + ":" + blue(target));
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {

  video.loadPixels();
  image(video, 0, 0);

  blobs.clear();
  closeBlobs.clear();

  avgX = 0;
  avgY = 0;
  blobWidth = 0;
  blobHeight = 0;
  int count = 0;

  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int loc = x + y * video.width;
      color capture = video.pixels[loc];

      float r1 = red(capture);
      float g1 = green(capture);
      float b1 = blue(capture);     
      float r2 = red(target);
      float g2 = green(target);
      float b2 = blue(target);

      dist = distSq(r1, g1, b1, r2, g2, b2);

      threshood = 80;

      if (dist < threshood * threshood) {

        rectMode(CENTER);
        stroke(0);
        fill(255);

        avgX += x;
        avgY += y;
        count++;

        if (closePixel(x, y)) {
          blobWidth =  max(x, blobWidth);
          blobHeight = max(y, blobWidth);
        }
      }
    }
  }

  if (count > 200) {
    avgX = avgX / count;
    avgY = avgY / count;
  }


  rect(avgX, avgY, blobWidth, blobHeight);
}

float calculateW() {
  return 0;
}

float calculateH() {
  return 0;
}

void addPixels() {
  
}

boolean closePixel(float x, float y) {
  
  float relDist = distSq(avgX, avgY, x, y);

  if (relDist < blobThreshold * blobThreshold) {
    return true;
  } else {
    return false;
  }
}

void RelativeBlobs(Blob a, Blob b) {

  float cx = video.width / 2 ;
  float cy = video.height / 2;

  cx = relXPos / blobs.size();
  cy = relYPos / blobs.size();

  float dA = 0;
  float dB = 0;

  dA = distSq(cx, cy, a.centerX(), a.centerY());
  dB = distSq(cx, cy, b.centerX(), b.centerY());

  println(abs(dA - dB));

  if (abs(dA - dB) < pow(map(mouseX, 0, width, 0, 120), 2)) {
    closeBlobs.add(a);
    closeBlobs.add(b);
  } else {
    if (dA > 100) {
      closeBlobs.remove(a);
    } else {
      closeBlobs.remove(b);
    }
  }
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1) + (z2 - z1) * (z2 - z1);
  return d;
}

float distSq(float x1, float y1, float x2, float y2) {
  return (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1);
}