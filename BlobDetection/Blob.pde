float blobThreshold = 75;

void keyPressed() {
  if (key == 'z') {
    blobThreshold++;
  } else if (key == 'x') {
    blobThreshold--;
  }

  println(blobThreshold);
}

class Blob {

  float minX;
  float minY;
  float maxX;
  float maxY;

  Blob(float x, float y) {
    minX = x;
    minY = y;
    maxX = x;
    maxY = y;
  }


  void show() {
    stroke(0);
    strokeWeight(2);
    fill(target, 10);
    rectMode(CORNERS);
    rect(minX, minY, maxX, maxY);
  }
  
  float size() {
    return (maxX - minX) * (maxY - minY);
  }

  void add(float x, float y) {
    minX = min(minX, x);
    minY = min(minY, y);
    maxX = max(maxX, x);
    maxY = max(maxY, y);
  }

  boolean isNear(float x, float y) {
    float cx = (minX + maxX) / 2;
    float cy = (minY + maxY) / 2;
    
    float d = distSq(cx, cy, x, y);

    if (d < blobThreshold * blobThreshold) {
      return true;
    } else {
      return false;
    }
  }
}