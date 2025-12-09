boolean[] img2 = {};
boolean[] buffer = {};
boolean[] error = {};
int[] spread = {};
int[] cumulerror = {};
PrintWriter imgoutput;
PrintWriter xyoutput;
int curframe = 0;
static final int WIDTH = 43;
static final int HEIGHT = 32;
static final int SWIDTH = WIDTH - 7;
static final int SHEIGHT = HEIGHT - 14;
static final int SCALE = 1;
void setup() {
  //3*WIDTH*SCALE, 2*HEIGHT*SCALE
  size(3*43*1, 2*32*1);
  noSmooth();
  imgoutput = createWriter("imgout.txt");
  xyoutput = createWriter("xyout.txt");
  buffer = new boolean[WIDTH * HEIGHT];
  cumulerror = new int[WIDTH * HEIGHT];
}

void draw() {
  scale(SCALE);
  if (curframe >= 6487) {
    imgoutput.flush();
    imgoutput.close();
    xyoutput.flush();
    xyoutput.close();
    exit();
  }

  PImage img = loadImage("img-" + (curframe + 45) + ".png");
  img2 = new boolean[0];
  for (int i = 0; i < img.pixels.length; i++) img2 = (boolean[])append(img2, brightness(img.pixels[i]) >= 128);

  error = new boolean[WIDTH * HEIGHT];
  spread = new int[SWIDTH * SHEIGHT];
  img.loadPixels();

  for (int i = 0; i < buffer.length; i++) {
    error[i] = img2[i] != buffer[i];
  }

  for (int y = 0; y < SHEIGHT; y++) {
    for (int x = 0; x < SWIDTH; x++) {
      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 15; j++) {
          spread[x + y * SWIDTH] += cumulerror[x + i + (y + j) * WIDTH] + (error[x + i + (y + j) * WIDTH] ? 1 : 0);
        }
      }
    }
  }
  float maxspread = 0;
  int maxx = 0;
  int maxy = 0;
  for (int y = 0; y < SHEIGHT; y++) {
    for (int x = 0; x < SWIDTH; x++) {
      if (spread[x + y * SWIDTH] > maxspread) {
        maxspread = spread[x + y * SWIDTH];
        maxx = x;
        maxy = y;
      }
    }
  }
  xyoutput.print(maxx);
  xyoutput.print(",");
  xyoutput.println(maxy);

  for (int y = 0; y < 15; y++) {
    imgoutput.print("0b");
    for (int x = 0; x < 8; x++) {
      error[x + maxx + (y + maxy) * WIDTH] = false;
      cumulerror[x + maxx + (y + maxy) * WIDTH] = 0;
      if (img2[x + maxx + (y + maxy) * WIDTH] != buffer[x + maxx + (y + maxy) * WIDTH]) {
        imgoutput.print(1);
        if (buffer[x + maxx + (y + maxy) * WIDTH]) {
          buffer[x + maxx + (y + maxy) * WIDTH] = false;
        } else {
          buffer[x + maxx + (y + maxy) * WIDTH] = true;
        }
      } else {
        imgoutput.print(0);
      }
    }
    imgoutput.print(",");
  }
  imgoutput.println();

  for (int i = 0; i < error.length; i++) {
    cumulerror[i] += error[i] ? 1 : 0;
  }

  img.updatePixels();
  for (int x = 0; x < WIDTH; x++) {
    for (int y = 0; y < HEIGHT; y++) {
      stroke(img2[x + y * WIDTH] ? 255 : 0);
      point(x, y);
      stroke(buffer[x + y * WIDTH] ? 255 : 0);
      point(x + WIDTH, y);
      stroke(error[x + y * WIDTH] ? 255 : 0);
      point(x + WIDTH, y + HEIGHT);
      stroke(cumulerror[x + y * WIDTH] * 10);
      point(x + 2 * WIDTH, y + HEIGHT);
    }
  }
  for (int x = 0; x < SWIDTH; x++) {
    for (int y = 0; y < SHEIGHT; y++) {
      stroke(spread[x + y * SWIDTH]);
      point(x, y + HEIGHT);
    }
  }
  //save("frame-"+curframe+".png"); //debug
  //wow a comment
  curframe++;
  //delay(500);
}
