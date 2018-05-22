
PImage pic;
int w = 300;

void setup() {
  size(1280, 1024);
  pic = loadImage("C:\\Users\\Century\\Desktop\\RC Car High Contrast Filmic.jpg");
}

float lineX = 0;
float speed = 14;

void draw() {
  
  int xstart = constrain(mouseX - w/2, 0, pic.width);
  int ystart = constrain(mouseY - w/2, 0, pic.height);
  int xend = constrain(mouseX + w/2, 0, pic.width);
  int yend = constrain(mouseY + w/2, 0, pic.height);
  
  image(pic, 0,0);

  loadPixels();
  pic.loadPixels();
  for (int x = xstart; x < xend; x++) {
    for (int y = ystart; y < yend; y++) {

      int location = x + y * width;
      
      int loc = x + y * pic.width ;
      
      loc = constrain(loc,0,pic.pixels.length-1);

      float r = red(pic.pixels[location]);
      float g = green(pic.pixels[location]);
      float b = blue(pic.pixels[location]);

      //float distance = dist(mouseX, mouseY, x, y);

      //float m = map(distance, 0, 200, 2, 0);

      //float bright = brightness(pic.pixels[location]);

      //if(bright > 100) {
      //  pixels[location] = color(0);
      //} else {
      //  pixels[location] = color(255);
      //}

      int locationZ = (x+1) + y * width;
      int locationY = x + (y + 1) * width;

      float diffX = brightness(pic.pixels[location]) - brightness(pic.pixels[locationY]);
      float diffY = brightness(pic.pixels[location]) - brightness(pic.pixels[locationZ]);


      //if (diffX > cons) {
      //  pixels[locationZ] = color(diffX + diffY);
      //} else {
      //  pixels[locationZ] = color(255);
      //}
      
      float diff = abs(diffX - diffY);
      
      if(diff > 30) {
        pixels[loc] = color(diffX + diffY);
      } else {
         pixels[loc] = color(255); 
      }
      
      //pixels[loc] = color(r, g, b);
      

      //temp = createImage((int)r, (int)g, (int)b);
    }
  }

  //image(temp, width, height);
  updatePixels();
}