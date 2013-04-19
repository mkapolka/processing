PVector gravity = new PVector(0, 1, 0);
float f = 0;

float bmaxdepth = 5000;
color butterfly_color = color(150, 100, 100);
PVector butterfly_velocity = new PVector(0,0,0);
PVector butterfly_posn = new PVector(0,0,-100);
PVector butterfly_target = new PVector(0, 0, -100);
float flap = 0;
float time = 0;
float target_speed = 50;
int nextFlap = 0;

float butterfly_y = 0;

int n_butterflies = 15000;

PImage noise;

//Used for calculating the FPS
int frames = 0;

boolean sketchFullScreen() {
   return false;
}

void setup() {
   //size(displayWidth, displayHeight, P3D);
   size(800, 600, P3D);
}

void tick() {
   if (nextFlap < millis()) {

      PVector target_velocity = PVector.sub(butterfly_target, butterfly_posn);
      target_velocity.add(PVector.random3D());
      target_velocity.normalize();
      target_velocity.mult(target_speed);

      //PVector d_velocity = PVector.sub(target_velocity, butterfly_velocity);
      //d_velocity.add(PVector.random3D());
      butterfly_velocity.set(target_velocity);

      nextFlap += 250;
   }

   //Gravity
   butterfly_velocity.add(gravity); 
   if (butterfly_velocity.y < -10) butterfly_velocity.y = -10;

   butterfly_posn.add(butterfly_velocity);
}

void draw() {
   tick();

	//background(170, 170, 255);
	background(20, 20, 20);

   float dx = mouseX - butterfly_posn.x;
   float dy = mouseY - butterfly_posn.y;
   //butterfly_velocity.x = dx;
   //butterfly_velocity.y = dy;
   butterfly_target.x = mouseX;
   butterfly_target.y = mouseY;

   pushMatrix();
      noStroke();

      translate(butterfly_posn.x, butterfly_posn.y, butterfly_posn.z);
      //translate(0, butterfly_y, 0);
      butterfly_y = sin(time) * (3 * height / 8);
      rotateX(90);

      fill(butterfly_color);
      butterfly(100,100,100, flap);
      flap += .2;
      time += PI / 100;
   popMatrix();

	frames++;
	text(frames / (millis() / 1000), 0, height);
}

void butterfly( float sx, float sy, float sz, float t) {
	float yf = sy * sin(t);
	float yb = sy * sin(t+PI/3);

	beginShape(TRIANGLES);
      vertex(0,0,0);
      vertex(sx,yb,-sz, 1, 0);
      vertex(sx,yf,sz, 0, 1);

      vertex(0,0,0, 1, 1);
      vertex(-sx,yb,-sz, 1, 0);
      vertex(-sx,yf,sz, 0, 1);
	endShape(CLOSE);
}
