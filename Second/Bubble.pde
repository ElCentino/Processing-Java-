
class Bubble {

  float x, y, counter;

  float speed = 2f;
  float dX, dY, diameter;
  float dSpeed;

  color col;

  Bubble(int x, int y, int diameter, color col) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.col = col;

    dY = dX = 1;
    dSpeed = 1;

    fill(col);
  }

  void start() {
    counter = 0;
  }

  void ascend() {


    if (y < diameter/2 || y > height - diameter/2) {
      dY = dY * -dSpeed;
    }

    if (x < diameter/2 || x > width - diameter/2)
    {
      dX = dX * -dSpeed;
    }
  }

  void display() {

    image(img, x, y, diameter, diameter);
    //ellipse(x, y, diameter, diameter);
  }

  void top() {
    y = y + dY * speed;
    x = x + dX * speed;
  }

  void computeBoth() {
    img.loadPixels(); 
    loadPixels();

    for (int row = 0; row < img.width; row++) {
      for (int col = 0; col < img.height; col++) {
        
        int loc = row + col * img.width;
        float r = red(img.pixels[loc]);
        float g = green(img.pixels[loc]);
        float b = blue(img.pixels[loc]);
        
        img.pixels[row + col * img.width] = color(g, b, r/2);
      }
    }

    img.updatePixels();
  }
}