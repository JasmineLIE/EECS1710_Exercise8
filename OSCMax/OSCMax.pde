//Reference: https://www.youtube.com/watch?v=FCazZMdSHtk&list=LL&index=4
import netP5.*;
import oscP5.*;
ArrayList<Stroke> strokes = new ArrayList<Stroke>();
OscP5 oscar;

int lineCount = 1000;
float intensity = 0.0;

void setup() {

  size(1280, 720, P3D);
  bloomSetup();
  strokeJoin(ROUND);
  strokeCap(ROUND);
  oscar = new OscP5(this, 6002);
  oscar.plug(this, "setAmp", "/amp");
}

public void setAmp(float amp) {
  intensity = amp * 100;
}

void draw() {
  background(0);

  if (mousePressed) {
    if (strokes.size() < 1) strokes.add(new Stroke());
    Stroke s = strokes.get(strokes.size()-1);
    if (s.points.size() < 1 || dist(mouseX, mouseY, pmouseX, pmouseY) > 2) {
      s.points.add(new PVector(mouseX, mouseY));
    }
  }
 
  tex.beginDraw();
  tex.background(0);
  for (int i=0; i<strokes.size(); i++) {
    strokes.get(i).run();
  }
  tex.endDraw();  
  
  bloomDraw();
   
  surface.setTitle(""+frameRate);
}
