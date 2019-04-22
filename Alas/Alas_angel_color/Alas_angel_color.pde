/**
 */
PImage sprite;  
int npartTotal = 500;
float partSize = 20;

PVector positions[];

int fcount, lastm;
float frate;
int fint = 3;


int numSegments = 200;
int apertura = 0;
int centro_espalda_x = 0;
int centro_espalda_y = 0;
int concavidad =0;
PShader blur;
int time=0;
boolean sumar= true;
boolean aleteo = false;
int aux;
int minMouse=0;
int maxMouse=0;

void setup() {
  size(1300,800,P3D);
  //fullScreen();
  sprite = loadImage("sprite.png");
  frameRate(50);
  initPositions();
  strokeWeight(4.0);
  noStroke();
  //noFill();
  blur = loadShader("blur.glsl"); 
  fill(200,50);
  centro_espalda_x =width/2;
  centro_espalda_y= height/2;
  noiseDetail(3);
  hint(DISABLE_DEPTH_MASK);
  aux=0;
}

void draw() {
  if(sumar)
  time++;
  else
  time--;

  if(time ==100)
  {
    sumar = false;
  }
  if(time<= 0)
  {
    sumar = true;
  }
  
  background(0,20); 
  pushMatrix();
  translate(width/2, height/2);
  rotateY(time * 0.001);
   for (int n = 0; n < npartTotal; n++) {
    drawParticle(positions[n]);
    }
  
  fcount += 1;
  int m = millis();
  if (m - lastm > 1000 * fint) {
    frate = float(fcount) / fint;
    fcount = 0;
    lastm = m;
    println("fps: " + frate); 
  }  
  popMatrix();
   
  apertura = 200;
  filter(blur);    
  for(int i=0; i<numSegments; i+=5) {
  fill(mouseY,mouseX,i*1.2,10);
   concavidad = 450-mouseY*3;
   bezier(mouseX-(2*apertura+i/4.0), concavidad+i, 200, mouseY, width/2+10, 300, centro_espalda_x,centro_espalda_y+i/2 );
   bezier(mouseX+(2*apertura+i/4.0), concavidad+i, 1000, mouseY, width/2-10, 300, centro_espalda_x, centro_espalda_y+i/2);
 }
 
 if(mouseY<minMouse)
 {
   minMouse = mouseY;
 }
 if(mouseY>maxMouse)
 {
   maxMouse = mouseY;
 }
 
 if((maxMouse-minMouse)>(height/2))
 {
   aleteo = true;
   minMouse=height/2;
   maxMouse=minMouse;
 }
 
  if(aleteo)
   {
     aux = 20;
     aleteo=false;
   }
  if (aux>0)
  {
    aletear();
  }

}

void aletear()
 {
  for(int a=0; a<aux; a++)
   {
   Positions_inc();
   }
   aux--;
 }
 
void drawParticle(PVector center) {
  beginShape(QUAD);
  noStroke();
  tint(205);
  texture(sprite);
  normal(0, 0, 1);
  vertex(center.x - partSize/2, center.y - partSize/2, center.z, 0, 0);
  vertex(center.x + partSize/2, center.y - partSize/2, center.z, sprite.width, 0);
  vertex(center.x + partSize/2, center.y + partSize/2, center.z, sprite.width, sprite.height);
  vertex(center.x - partSize/2, center.y + partSize/2, center.z, 0, sprite.height);                
  endShape();  
}

void initPositions() {
  positions = new PVector[npartTotal];
  for (int n = 0; n < positions.length; n++) {
    positions[n] = new PVector(random(-500, +500), random(-500, +500), random(-500, +500));
  }  
}

void Positions_inc() {
  for (int n = 0; n < positions.length; n++) {
    positions[n].y+=1;
    if(positions[n].y > height)
    {
      positions[n] = new PVector(random(-500, +500), random(-500, 50), random(-500, +500));
    }
  }  
}
