
int left, right;

void setup()
{
  size(600, 360);
  

  left = 30;
  right = 30;
  
  background(50);
}

void draw()
{ 
  //background(50);
  rectMode(CENTER);
  //rect(mouseX, mouseY, 100, 100);
  
  stroke(255, 0, 0);
  
  if(mousePressed)
  {
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
  
  

  redraw();
}