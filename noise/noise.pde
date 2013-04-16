int width = 300;
int height = 300;
int mod = 2;

PImage img;

void setup() {
	img = createImage(width, height, RGB);
	size(width, height);
	//genModulo(img, mod);
   genPerlin(img);
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
void genModulo(PImage img, int mod) {
	img.loadPixels();
	int i = 0;
	for (int x = 0; x < img.width; x++) {
		for (int y = 0; y < img.height; y++) {
			float fx = x + 0.5;
			float fy = y + 0.5;
			img.pixels[(y * height) + x] = ((int)(fx * fy) % mod == 0)?color(0):color(255);
		}
	}
	img.updatePixels();
}

void draw() {
	background(1);
	image(img, 0, 0);
}

void keyPressed() {
	if (key == ' ') {
		mod++;
		if (mod > 100) mod = 2;
		genModulo(img, mod);
	}
}
