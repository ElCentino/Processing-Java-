
Bubble b, b1;

PImage img;

void setup() {
  size(630, 360, P2D);
  b = new Bubble(width/2, height - 50, 64, color(255, 0, 0));
  b1 = new Bubble(width/ 2 - 200, height - 200, 56, color(143, 0, 233));
  img = loadImage("C:\\Users\\Century\\Desktop\\icon-128.png");
}

void draw() {

  background(255);
  imageMode(CENTER);
  
  b.ascend();
  b.display();
  b.top();

  b1.ascend();
  b1.display();
  b1.top();
  
  detectCollision(b, b1);
}

float distance(float x1, float y1, float x2, float y2) {
    
    float x = x2 - x1;
    float y = y2 - y1;
    
    float d = sqrt((x*x) + (y*y));
    
    return d;
  }
  
  

  void detectCollision(Bubble a, Bubble b) {
    float distance = distance(a.x, a.y, b.x, b.y);
    
    println(distance);
    
    if(distance < a.diameter/2 + b.diameter/2) {
      
       a.computeBoth();
       b.computeBoth();
       
       a.dY = a.dY * -a.dSpeed;
       b.dY = b.dY * -b.dSpeed;
       
       a.dX = a.dX * -a.dSpeed;
       b.dX = b.dX * -b.dSpeed;
    }
  }