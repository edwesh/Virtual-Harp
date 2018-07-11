/*
Drawing the harp strings and synchronize the strings
with the position that the finger touched.
*/
class H_string {
  int ver;
  int inter = (390 - 35)/36;
  int str_num = (390 - 35)/inter;
  PVector[] v_top = new PVector[str_num * 2];
  PVector[] v_bot = new PVector[str_num * 2];
  float[] f;
  boolean getDraw;
  int x;
  int y;
  float a;
  float b;

  H_string(int x, int y, boolean getDraw) {
    this.getDraw = getDraw; 
    this.x = x;
    this.y = y;   

    translate(-x, -y);
    stroke(136, 144, 153);
    strokeWeight(2);

    for (int j = 0; j < height; j++)
    {
      for (int i = 0; i < width; i++)
      {  
        color c = get(i, j); 
        if (red(c) != 80 && green(c) != 55 && blue(c) != 40)
        {

          c = get(i, j+1);
          if (red(c) != 235 && green(c) != 218 && blue(c) != 38 && red(get(i, j-1)) == 235 && green(get(i, j-1)) == 218 && blue(get(i, j-1)) == 38)
          {

            if ((i >= x + 35 && i <= x + 390) && (j >= y + 65 && j <= y + 131))
            {
              ver = j;
              do {
                ver ++;
                c = get(i, ver);
              } 
              while (red (c) != 235 && green(c) != 218 && blue(c) != 38);


              if (i%inter == 0)
              {
                if (getDraw == true)
                {
                  line(i, j, i, ver);
                  if ((position.x >= i - inter/2 && position.x <= i + inter/2) && (position.y > j && position.y < ver))
                  {

                    fill(random(0, 255), random(0, 255), random(0, 255));
                    ellipse(position.x, position.y, 25, 25);
                    a = i;
                    b = j;

                    for (int u = 0; u < v1.length; u++)
                    {
                      if (v1[u].x == a)
                      {                
                        playMusic(int(v1[u].x));
                      }
                    }
                  }
                } else
                {
                  v_top[num] = new PVector(i, j);
                  v_bot[num] = new PVector(i, ver);
                  num++;
                }
              }
            }
          }
        }
      }
    }
  }
}











