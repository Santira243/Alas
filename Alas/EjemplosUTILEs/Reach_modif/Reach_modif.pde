/**
 * Reach 2  
 * based on code from Keith Peters.
 * 
 * The arm follows the position of the mouse by
 * calculating the angles with atan2(). 
 */

int numSegments = 4;
int numSegments2 = 6;
float[] x = new float[numSegments];
float[] y = new float[numSegments];
float[] angle = new float[numSegments];
float segLength =50;
float targetX, targetY;
float targetX1, targetY1;

float[] x2 = new float[numSegments2];
float[] y2 = new float[numSegments2];
float[] angle2 = new float[numSegments2];
float segLength2 =40;


void setup() {
  size(800,600);
  strokeWeight(20.0);
  stroke(255, 100);
  x[x.length-1] = width/2;     // Set base x-coordinate
  y[x.length-1] = height/2;  // Set base y-coordinate
  x2[x2.length-1] = width/2;     // Set base x-coordinate
  y2[x2.length-1] = height/2+ 80;  // Set base y-coordinate
}

void draw() {
  background(0); 
  reachSegment(0, mouseX, mouseY);
  reachSegment2(0, x[0]+cos(angle[0]) * segLength, y[0]+10+sin(angle[0]) * segLength);
  
  for(int i=1; i<numSegments; i++) {
    reachSegment(i, targetX, targetY);
  }
  for(int i=1; i<numSegments2; i++) {
    reachSegment2(i, targetX1, targetY1+i*2.5);
  }
  
  for(int i=x.length-1; i>=1; i--) {
    positionSegment(i, i-1);   
  } 
  
  for(int i=x2.length-1; i>=1; i--) {
    positionSegment2(i, i-1);   
  } 
  
  for(int i=0; i<x.length; i++) {
    segment(x[i], y[i], angle[i], (i+10)*1.5, segLength);
  }
  
  for(int i=0; i<x2.length; i++) {
     segment(x2[i], y2[i], angle2[i],(i+2)*1.5, segLength2);
  }
 
}

void positionSegment(int a, int b) {
  x[b] = x[a] + cos(angle[a]) * segLength;
  y[b] = y[a] + sin(angle[a]) * segLength; 
}

void positionSegment2(int a, int b) {
  x2[b] = x2[a] + cos(angle2[a]) * segLength2;
  y2[b] = y2[a] + sin(angle2[a]) * segLength2; 
}


void reachSegment(int i, float xin, float yin) {
  float dx = xin - x[i];
  float dy = yin - y[i];
  angle[i] = atan2(dy, dx);  
  targetX = xin - cos(angle[i]) * segLength;
  targetY = yin - sin(angle[i]) * segLength;
}
void reachSegment2(int i1, float xin1, float yin1) {
  float dx1 = xin1 - x2[i1];
  float dy1 = yin1 - y2[i1];
  angle2[i1] = atan2(dy1, dx1);  
  targetX1 = xin1 - cos(angle2[i1]) * segLength2;
  targetY1 = yin1 - sin(angle2[i1]) * segLength2;
}

void segment(float x, float y, float a, float sw, float sl) {
  strokeWeight(sw);
  pushMatrix();
  translate(x, y);
  rotate(a);
  line(0, 0, sl, 0);
  popMatrix();
}
