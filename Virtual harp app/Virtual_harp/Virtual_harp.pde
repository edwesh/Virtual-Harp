/*
Add FingerTracker library into Processing/libraries before run the program.
*/
import SimpleOpenNI.*;
import fingertracker.*;
import oscP5.*;
import netP5.*;
import ddf.minim.*;

FingerTracker fingers;
SimpleOpenNI context;
OscP5 osc;
NetAddress address;
AudioPlayer player;
Minim minim;

Harp h;

float size_wid;
float size_hei;
PVector position;
int threshold = 800;
int num;
PVector[] v1 = new PVector[78];
PVector[] v2 = new PVector[78];
float h_volume = 0.038;
boolean pressed = false;
String text1 = "Harp volume: ";
String text2 = "Threshold value: ";

final int[] Rhy = {
  51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90
};

void setup() {

  size(1280, 800, P3D);
  size_wid = width;
  size_hei = height;

  h = new Harp(width/2, height/6, false);

  v1 = h.s.v_top;  
  v2 = h.s.v_bot;

  println("------------------------------------");

  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  context.enableDepth();
  context.setMirror(true);

  fingers = new FingerTracker(this, 640, 480);
  fingers.setMeltFactor(100);



  address = new NetAddress("127.0.0.1", 10086);
  osc = new OscP5(this, 11000);
  minim = new Minim(this);
}


void draw() {
  context.update();

  context.setDepthImageColor(80, 55, 40);
  PImage depthImage = context.depthImage();
  image(depthImage, 0, 0, size_wid, size_hei);
  fingers.setThreshold(threshold);

  int[] depthMap = context.depthMap();
  fingers.update(depthMap);

  noStroke();
  fill(255, 0, 0);
  for (int i = 0; i < fingers.getNumFingers (); i++) {
    position = fingers.getFinger(i);
    position.x = position.x / (640 / size_wid) -5;
    position.y = position.y / (480 / size_hei);
  }
  
  fill(255, 0, 0);
  ellipse(position.x, position.y, 25, 25);
  fill(0,255,0);
  text(text1 + h_volume,50,60);
  text(text2 + threshold,50,80);
  h = new Harp(width/2, height/6, true);

}

/*
Convert the x-axis of the coordinates into 
string number when play the harp strings.
*/
void playMusic(int pass) {
  int cord = pass/9 - 75;
  toPD(cord, h_volume);

}

/*
Send message to pure data with
two parematers which one is for the tones
and the other for volume. The default volume
is 0.038
*/
void toPD(int pitch, float volume) {
  OscMessage message = new OscMessage("/puredata");

  message.add(Rhy[pitch]);
  message.add(volume);
  osc.send(message, address);
}

/*
Click the mouse to play the background music 
or stop playing the music.
*/
void mousePressed() {
  pressed = !pressed;
  if (pressed == true)
  {  
    player = minim.loadFile("dubstep.mp3", 2048);
    player.loop();
  } else if (pressed == false)
    minim.stop();
}


/*
Adjust harp valume and threshold value by pressing the key 
'↑', '↓', '←', '→'.
*/
void keyPressed(){
  if(h_volume >= 0.03 && h_volume <= 0.2)
  {  
    if(keyCode == UP)
    {
      h_volume += 0.01;
    }
    else if(keyCode == DOWN)
    {
      h_volume -= 0.01;
    }
  }
  if(h_volume > 0.2)
  {
    h_volume = 0.2;
  }
  if(h_volume < 0.03)
  {
     h_volume = 0.03;
  }
  
  if(keyCode == LEFT)
  {
    threshold -= 10;
  }
  else if(keyCode == RIGHT)
  {
    threshold += 10;
  }
 
}



