
float pixelThreshold = 120;

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

  void addPoint(float x, float y) {
    startingWidth = max(startingWidth, x);
    startingHeight = max(startingHeight, y);
    startingPointX = min(startingPointX, x);
    startingPointY = min(startingPointY, y);
  }

  float getComputedPixels() {
    float pixelsX = abs(startingWidth - startingPointX);
    float pixelsY = abs(startingHeight - startingPointY);

    float totalPixels = pixelsX * pixelsY;

    return totalPixels;
  }

  boolean isNear(float x, float y) {

    float cx = (startingWidth + startingPointX) / 2;
    float cy = (startingHeight + startingPointY) / 2;

    float dist = distanceSq(cx, cy, x, y);

    if (dist < pixelThreshold * pixelThreshold) {
      return true;
    } else {
      return false;
    }
  }

  void show() {
    
    fill(0);
    textSize(16);
    text("W : " + startingWidth + " H : " + startingHeight , startingPointX, startingPointY);
    
    fill(0, 0, 255, 20);
    stroke(0);
    strokeWeight(2);
    rectMode(CORNERS);

    rect(startingPointX, startingPointY, startingWidth, startingHeight);
  }
}