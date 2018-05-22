
import processing.video.*;

Movie mov;

void setup() {
  size(1200, 800);
  mov = new Movie(this, "C:\\Users\\Century\\Documents\\Processing\\video.avi");
  mov.play();
}

void movieEvent(Movie mov) {
  mov.read();
}

void draw() {
}