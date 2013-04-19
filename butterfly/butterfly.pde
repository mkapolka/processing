float f = 0;

float bmaxdepth = 5000;

int n_butterflies = 15000;
color[] bcolors = new color[n_butterflies];
PVector[] bcoords = new PVector[n_butterflies];
float[] bts = new float[n_butterflies];

PImage noise;

//Used for calculating the FPS
int frames = 0;

boolean sketchFullScreen() {
   return true;
}

void setup() {
   size(displayWidth, displayHeight, P3D);

	for (int i = 0; i < n_butterflies; i++) {
		bcolors[i] = color(100 + random(155), random(100), random(100));
      bcoords[i] = new PVector();
		resetButterfly(i);
      PVector d = new PVector(width/2,height/2,-bmaxdepth);
      d.sub(bcoords[i]);
      d.mult(random(1));
      bcoords[i].add(d);

		bts[i] = random(PI*2);
	}

   noise = createImage(512, 512, RGB);
   genPerlin(noise);
}

void genPerlin(PImage img) {
   img.loadPixels();
   float sc = 0.03;
   int i = 0;
   for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width; x++) {
         float ys = y * sc;
         float xs = x * sc;
         img.pixels[i++] = color(noise(xs,ys) * 254);
      }
   }
   img.updatePixels();
}

void resetButterfly(int i) {
	switch (floor(random(4))) {
		//Top
		case 0:
			bcoords[i].x = random(width);
			bcoords[i].y = height;
		break;
		//Right
		case 1:
			bcoords[i].x = width;
			bcoords[i].y = random(height);
		break;
		//Bottom
		case 2:
			bcoords[i].x = random(width);
			bcoords[i].y = 0;
		break;
		//Left
		case 3:
			bcoords[i].x = 0;
			bcoords[i].y = random(height);
		break;
	}
	bcoords[i].z = random(0);
}

void draw() {
	//background(170, 170, 255);
	background(20, 20, 20);

	for (int i = 0; i < n_butterflies; i++) {
		pushMatrix();
			noStroke();

			if (bcoords[i].z < -bmaxdepth) resetButterfly(i);
			translate(bcoords[i].x, bcoords[i].y, bcoords[i].z);
			//bcoords[i].z -= 5;
			//rotateZ(0);

         PVector towards = new PVector(width/2,height/2,-bmaxdepth);
         towards.sub(bcoords[i]);
         towards.normalize();
         towards.mult(5);

         bcoords[i].add(towards);

			/*bcolors[i] &= 0x00FFFFFF;
			int b = 255 - (byte)((pow(bcoords[i].z / bmaxdepth, 2)) * 255);
			bcolors[i] |= b << 24;*/

			fill(bcolors[i]);
			butterfly(10,10,10, bts[i]);
			bts[i] += .2;
		popMatrix();
	}

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
