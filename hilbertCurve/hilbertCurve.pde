int order = 7;
int N = int(pow(2, order));
int total = N * N;

PVector[] path = new PVector[total];

void setup() {
  size(1920, 1920);
  colorMode(HSB, 360, 255, 255);
  background(0);
  float len = width / N;

  for (int i = 0; i < total; i++) {
    path[i] = hilbert(i);
    path[i].mult(len);
    path[i].add(len/2, len/2);
  }
}

int counter = 0;
void draw() {
  background(0);

  stroke(255);
  strokeWeight(1);
  noFill();
  //beginShape();
  for (int i = 1; i < counter; i++) {
    float h = map(i, 0, path.length, 0, 360);
    stroke(h, 255, 255);
    line(path[i].x, path[i].y, path[i-1].x, path[i-1].y);
    square(path[i].x, path[i].y, order);
    //square(path[i].x, path[i].y, order);
    //fill(map(i, 1, path.length, 1, 360));
  }
  //endShape();

  counter+=50;
  if (counter >= path.length) {
    counter = 0;
    
    save("hilbert.png");
    //exit();
  }

  //strokeWeight(4);
  //for (int i = 0; i < path.length; i++) {
  //  point(path[i].x, path[i].y);
  //  text(i, path[i].x+5, path[i].y);
  //}
}


PVector hilbert(int i) {
  PVector[] points = {
    new PVector(0, 0), 
    new PVector(0, 1), 
    new PVector(1, 1), 
    new PVector(1, 0)
  };

  int index = i & 3;
  PVector v = points[index];

  for (int j = 1; j < order; j++) {
    i = i >>> 2;
    index = i & 3;
    float len = pow(2, j);
    if (index == 0) {
      float temp = v.x;
      v.x = v.y;
      v.y = temp;
    } else if (index == 1) {
      v.y += len;
    } else if (index == 2) {
      v.x += len;
      v.y += len;
    } else if (index == 3) {
      float temp = len - 1 - v.x;
      v.x = len - 1 - v.y;
      v.y = temp;
      v.x += len;
    }
  }
  return v;
}
