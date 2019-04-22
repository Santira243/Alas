/**
 */

int numSegments = 200;
int apertura = 0;
int centro_espalda_x = 0;
int centro_espalda_y = 0;
int concavidad =0;
void setup() {
  size(1000,600);
  strokeWeight(4.0);
  stroke(255,100);
  //noFill();
  fill(200,50);
  centro_espalda_x =width/2;
  centro_espalda_y= height/2;
}

void draw() {
  background(0,20); 
  apertura = 200;
  for(int i=0; i<numSegments; i+=5) {
   concavidad = 450-mouseY*3;
   bezier(mouseX-(2*apertura+i/4.0), concavidad+i, 200, mouseY, width/2+10, 300, centro_espalda_x,centro_espalda_y+i/2 );
   bezier(mouseX+(2*apertura+i/4.0), concavidad+i, 1000, mouseY, width/2-10, 300, centro_espalda_x, centro_espalda_y+i/2);
 }
   
}
