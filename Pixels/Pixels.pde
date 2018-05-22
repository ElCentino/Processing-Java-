
void setup() {
  size(1000, 600);
  background(0);
}

void draw() {
  loadPixels();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      pixels[x+y * width] = color(random(255));
    }
  }

  updatePixels();
}