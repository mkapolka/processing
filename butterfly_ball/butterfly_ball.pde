int wwidth = 800;
int wheight= 600;

float f = 0;

float bmaxdepth = 5000;

int n_butterflies = 1000;
color[] bcolors = new color[n_butterflies];
float[][] bcoords = new float[n_butterflies][3];
float[] bts = new float[n_butterflies];
//X,Y,Z components of angle axis per butterfly
PVector[] bas = new PVector[n_butterflies];

//Used for calculating the FPS
int frames = 0;

boolean sketchFullScreen() {
   return true;
}

void setup() {
   wwidth = displayWidth;
   wheight = displayHeight;
   size(wwidth,wheight, P3D); 

	for (int i = 0; i < n_butterflies; i++) {
		bcolors[i] = color(100 + random(155), random(100), random(100));
		resetButterfly(i);
		bts[i] = random(PI*2);
      bas[i] = PVector.random3D();
	}
}

void resetButterfly(int i) {
   bcoords[i][0] = random(150);
   bcoords[i][1] = random(50);
   bcoords[i][2] = random(50);
}

void draw() {
	//background(170, 170, 255);
	background(20, 20, 20);

   pushMatrix();
   translate(width/2,height/2,-100);
   rotate(bts[0], bas[0].x, bas[0].y, bas[0].z);
	for (int i = 0; i < n_butterflies; i++) {
		pushMatrix();
			noStroke();

			if (bcoords[i][2] < -bmaxdepth) resetButterfly(i);
         rotate(-bts[i], bas[i].x, bas[i].y, bas[i].z);
         translate(100 + bcoords[i][0], 0, 0);

			fill(bcolors[i]);
			butterfly(6,6,6, bts[i] * 60);
         if (i == 0) {
            bts[i] += .006;
         } else {
            bts[i] += .002;
         }
		popMatrix();
	}
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
