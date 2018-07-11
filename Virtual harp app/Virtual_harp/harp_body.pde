/*
Drawing the framework of the harp.
*/
class Harp {
  H_string s;
  int x = 0;
  int y = 0;
  boolean getDraw;
  Harp(int x, int y, boolean getDraw) {
    this.getDraw = getDraw;
    this.x = x;
    this.y = y; 
    translate(x, y);

    noStroke(); 
    fill(163, 137, 34);
    ellipse(35, 464, 100, 25);
    fill(0);
    ellipse(35, 458, 100, 25);

    fill(235, 218, 38);
    beginShape();  
    curveVertex(0, 50);
    curveVertex(0, 50);
    curveVertex(15, 47.5);
    curveVertex(30, 50);
    curveVertex(27, 58);
    curveVertex(3, 58);
    curveVertex(0, 50);
    curveVertex(15, 47.5);
    endShape();

    beginShape();  
    curveVertex(3, 450);
    curveVertex(3, 450);
    curveVertex(27, 450);
    curveVertex(30, 458);
    curveVertex(15, 460.5);
    curveVertex(0, 458);
    curveVertex(3, 450);
    curveVertex(27, 450);
    endShape();

    beginShape();
    vertex(3, 58);
    vertex(3, 450);
    vertex(27, 450);
    vertex(27, 58);
    endShape();

    beginShape();
    curveVertex(27, 58);
    curveVertex(27, 58);
    curveVertex(138.5, 47.5);
    curveVertex(275, 110);
    curveVertex(347.5, 90);
    curveVertex(425, 110);
    curveVertex(425, 110);
    vertex(405, 125);
    curveVertex(405, 125);
    curveVertex(405, 125);
    curveVertex(347.5, 110.5);
    curveVertex(275, 130.5);
    curveVertex(138.5, 68);
    curveVertex(27, 78.5);
    curveVertex(27, 78.5);
    endShape();

    beginShape();
    vertex(27, 462.5);
    vertex(425, 105);
    curveVertex(425, 105);
    curveVertex(425, 105);
    curveVertex(433, 115);
    curveVertex(433, 115);
    vertex(65, 460);
    endShape();   

    s = new H_string(x, y, getDraw);
  }
}


