int width = 300;
int height = 300;
int mod = 2;

PImage img;

void setup() {
	img = createImage(width, height, RGB);
	size(width, height);
	genModulo(img, mod);
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
