import processing.video.*;

float dist;
float threshood = 0;
color target;

ArrayList<Blob> blobs = new ArrayList<Blob>();

Capture video;

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480, 30);
  video.start();

  target = color(87, 86, 255);

  printArray(Capture.list());
}

void mousePressed() {
  target = video.get(mouseX, mouseY);
  print(red(target)+":"+ green(target) + ":" + blue(target));
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {

  text("Threshold : " + threshood, width, 50);

  image(video, 0, 0, width, height);

  blobs.clear();

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

        boolean found = false;

        for (Blob b : blobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob b = new Blob(x, y);
          blobs.add(b);
        }
      }
    }
  }

  for (Blob b : blobs) {
    if (b.size() > 1000) {
      b.show();
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