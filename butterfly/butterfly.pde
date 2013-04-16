float f = 0;

float bmaxdepth = 5000;

int n_butterflies = 2000;
color[] bcolors = new color[n_butterflies];
float[][] bcoords = new float[n_butterflies][3];
float[] bts = new float[n_butterflies];

//Used for calculating the FPS
int frames = 0;

void setup() {
   size(800,600, P3D); 

	for (int i = 0; i < n_butterflies; i++) {
		bcolors[i] = color(100 + random(155), random(100), random(100));
		resetButterfly(i);
		bcoords[i][2] = random(-bmaxdepth);
		bts[i] = random(PI*2);
	}
}

void resetButterfly(int i) {
	switch (floor(random(4))) {
		//Top
		case 0:
			bcoords[i][0] = random(width);
			bcoords[i][1] = height;
		break;
		//Right
		case 1:
			bcoords[i][0] = width;
			bcoords[i][1] = random(height);
		break;
		//Bottom
		case 2:
			bcoords[i][0] = random(width);
			bcoords[i][1] = 0;
		break;
		//Left
		case 3:
			bcoords[i][0] = 0;
			bcoords[i][1] = random(height);
		break;
	}
	bcoords[i][2] = random(0);
}

void draw() {
	background(170, 170, 255);

	for (int i = 0; i < n_butterflies; i++) {
		pushMatrix();
			noStroke();
			if (bcoords[i][2] < -bmaxdepth) resetButterfly(i);
			translate(bcoords[i][0], bcoords[i][1], bcoords[i][2]);
			//bcoords[i][1] += sin(PI * millis() / 1000) * 10;
			bcoords[i][2] -= 5;
			rotateZ(0);

			bcolors[i] &= 0x00FFFFFF;
			int b = 255 - (byte)((pow(bcoords[i][2] / bmaxdepth, 2)) * 255);
			bcolors[i] |= b << 24;

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

	beginShape();
	vertex(0,0,0);
	vertex(sx,yb,-sz);
	vertex(sx,yf,sz);

	vertex(0,0,0);
	vertex(-sx,yb,-sz);
	vertex(-sx,yf,sz);

	vertex(0,0,0);
	endShape();
}
