import ddf.minim.*;

Minim minim;
AudioPlayer player;

float DefaultScale = 0.15;
float FR = 29;
float SampleRate = 10;

boolean running = true;
boolean DEBUGGING = false;
boolean SoundOn = true;

float t = 0;
float scale = DefaultScale;
color transparent = color(0, 0, 0, 0);
color red = color(244, 0, 9);
color white = color(255, 255, 255);
ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<Integer> lineColor = new ArrayList<Integer>();
ArrayList<Integer> strokes = new ArrayList<Integer>();

void setup()
{
  fullScreen(P2D);
  //size(800, 800, P2D);
  background(0);
  noFill();
  smooth();
  frameRate(FR);
  
  minim = new Minim(this);
  player = minim.loadFile("Popshop Theme.mp3");
  if(SoundOn)
    player.loop();
}

void keyPressed() {
  if(key == ' ')
    running = !running;
  if(key == 'r')
    reset();
}

void reset()
{
  frameCount = -1;
  t = 0;
  lineColor.clear();
  strokes.clear();
  points.clear();
  minim.stop();
  minim = new Minim(this);
  if(SoundOn)
    player.loop();
  scale = DefaultScale;
}

float updateT(float T)
{
  T += 0.003;
  
  if(T >= 156.998) { //END
    strokes.add(1);
    lineColor.add(color(0, 0, 0));
    return 52 * PI;
  }
  if(T >= 150.806 && T < 156.998) { //DASH
    strokes.add(4);
    lineColor.add(red);
    return T + 0.006;
  }
  if(T >= 144.459 && T < 150.806) { //SKIP
    strokes.add(1);
    lineColor.add(red);
    return 150.806;
  }
  if(T >= 138.264 && T < 144.459) { //FIRST O INNER TOP
    strokes.add(3);
    lineColor.add(red);
    return T + 0.003;
  }
  if(T >= 131.897 && T < 138.264) { //SKIP
    strokes.add(1);
    lineColor.add(red);
    return 138.264;
  }
  if(T >= 125.690 && T < 131.897) { //SECOND O INNER TOP
    strokes.add(3);
    lineColor.add(red);
    return T + 0.003;
  }
  if(T >= 119.394 && T < 125.690) { //SKIP
    strokes.add(1);
    lineColor.add(red);
    return 125.690;
  }
  if(T >= 113.121 && T < 119.394) { //SECOND O INNER BOTTOM
    strokes.add(3);
    lineColor.add(red);
    return T + 0.003;
  }
  if(T >= 106.806 && T < 113.121) { //SKIP
    strokes.add(1);
    lineColor.add(red);
    return 113.121;
  }
  if(T >= 100.561 && T < 106.806) { //FIRST O INNER BOTTOM
    strokes.add(3);
    lineColor.add(red);
    return T + 0.003;
  }
  if(T >= 94.240 && T < 100.561) { //SKIP
    strokes.add(1);
    lineColor.add(red);
    return 100.561;
  }
  if(T >= 87.995 && T < 94.240) { //SECOND C INNER
    strokes.add(3);
    lineColor.add(red);
    return T + 0.003;
  }
  if(T >= 81.671 && T < 87.995) { //SKIP
    strokes.add(1);
    lineColor.add(red);
    return 87.995;
  }
  if(T >= 75.423 && T < 81.671) { //SECOND A INSIDE
    strokes.add(3);
    lineColor.add(red);
    return T + 0.003;
  }
  if(T >= 69.111 && T < 75.423) { //SKIP
    strokes.add(1);
    lineColor.add(red);
    return 75.423;
  }
  if(T >= 62.845 && T < 69.111) { //FIRST A INSIDE
    strokes.add(3);
    lineColor.add(red);
    return T + 0.003;
  }
  if(T >= 56.545 && T < 62.845) { //SKIP
    strokes.add(1);
    lineColor.add(red);
    return 62.845;
  }
  if(T >= 50.291 && T < 56.545) { //SEDCOND C TIP
    strokes.add(4);
    lineColor.add(red);
    return T + 0.003;
  }
  if(T >= 44.206 && T < 50.291) { //SKIP
    strokes.add(1);
    lineColor.add(red);
    return 50.291;
  }
  if(T >= 37.705 && T < 44.206) { //OCA OUTER
    strokes.add(4);
    lineColor.add(red);
    return T;
  }
  if(T >= 31.463 && T < 37.705) { //SKIP
    strokes.add(1);
    lineColor.add(red);
    return 37.705;
  }
  if(T >= 25.134 && T < 31.463) { //FIRST C OUTER
    strokes.add(4);
    lineColor.add(red);
    return T;
  }
  if(T >= 18.893 && T < 25.134) { //SKIP
    strokes.add(1);
    lineColor.add(red);
    return 25.134;
  }
  if(T >= 12.563 && T < 18.893) { //SECOND C OUTER
    strokes.add(4);
    lineColor.add(red);
    return T;
  }
  if(T >= 6.272 && T < 12.563) { //SKIP
    strokes.add(1);
    lineColor.add(red);
    return 12.573;
  }
  else { //OLA OUTER
    strokes.add(4);
    lineColor.add(red);
  }
  
  return T;
}

void draw()
{ 
  //if(frameCount < 30) return;
  if(t <= 52 * PI && running)
  {
    for(int z = 0; z<SampleRate; z++) {
      t = updateT(t);
      points.add(new PVector(x(t), -y(t)));
      if(DEBUGGING)
        print(t + "\n");
    }
  } else {
    if(!DEBUGGING)
      scale += 0.0002;
  }
  
  translate(width/2, height/2);
  background(0);
  
  beginShape();
  for(int i = 0; i < points.size(); i++)
  {
    if(points.get(i).x == 0 && points.get(i).y == 0) continue;
    strokeWeight(strokes.get(i));
    stroke(lineColor.get(i));
    point(points.get(i).x * scale, points.get(i).y * scale);
  }
  endShape();
}

float sgn(float x)
{
  if(x == 0) return 0;
  else if(x > 0) return 1;
  else return -1;
}

float theta(float x)
{
  if(x == 0) return 0.5;
  else if(x > 0) return 1;
  else return 0;
}

float SIN(float x)
{
  return sin(x);
}

float x(float t)
{
  return ((-3.0/41*sin(32.0/33 - 12*t) - 6.0/59*sin(41.0/33 - 8*t) - 2.0/23*sin(36.0/29 - 4*t) + 8301.0/43*sin(t + 159.0/55) + 31.0/29*sin(2*t + 1.0/26) + 290.0/13*sin(3*t + 14.0/29) + 155.0/21*sin(5*t + 153.0/49) + 9.0/26*sin(6*t + 14.0/83) + 472.0/111*sin(7*t + 33.0/46) + 83.0/38*sin(9*t + 101.0/30) + 5.0/22*sin(10*t + 8.0/31) + 34.0/19*sin(11*t + 27.0/29) + 1337.0/41)*theta(51*PI -t)*theta(t - 47*PI) + (-2.0/19*sin(33.0/37 - 11*t) - 3.0/7*sin(32.0/37 - 9*t) - 7.0/13*sin(23.0/17 - 8*t) - 13.0/31*sin(14.0/15 - 7*t) - 191.0/60*sin(26.0/19 - 4*t) + 4283.0/25*sin(t + 121.0/36) + 779.0/67*sin(2*t + 37.0/28) + 330.0/31*sin(3*t + 18.0/7) + 68.0/39*sin(5*t + 65.0/22) + 609.0/305*sin(6*t + 73.0/16) + 2.0/11*sin(10*t + 5.0/29) + 17.0/44*sin(12*t + 12.0/29) - 31430.0/11)*theta(47*PI -t)*theta(t - 43*PI) + (-9.0/34*sin(4.0/11 - 12*t) - 11.0/31*sin(26.0/17 - 11*t) - 2.0/15*sin(53.0/62 - 10*t) - 9.0/16*sin(40.0/31 - 8*t) - 105.0/46*sin(29.0/23 - 4*t) + 8023.0/47*sin(t + 137.0/41) + 71.0/5*sin(2*t + 19.0/17) + 335.0/36*sin(3*t + 102.0/41) + 85.0/29*sin(5*t + 132.0/49) + 18.0/23*sin(6*t + 139.0/31) +sin(7*t + 92.0/27) + 16.0/23*sin(9*t + 125.0/32) + 18572.0/9)*theta(43*PI -t)*theta(t - 39*PI) + (-125.0/46*sin(11.0/10 - 8*t) - 134.0/31*sin(10.0/19 - 5*t) + 4355.0/17*sin(t + 142.0/41) + 4379.0/199*sin(2*t + 140.0/33) + 325.0/14*sin(3*t + 83.0/51) + 151.0/13*sin(4*t + 103.0/40) + 199.0/32*sin(6*t + 4.0/5) + 1437.0/718*sin(7*t + 81.0/28) + 26.0/19*sin(9*t + 10.0/37) + 37.0/38*sin(10*t + 103.0/40) + 69.0/43*sin(11*t + 22.0/5) + 35.0/32*sin(12*t + 7.0/24) + 32708.0/19)*theta(39*PI -t)*theta(t - 35*PI) + (-28.0/25*sin(1.0/22 - 9*t) - 73.0/21*sin(49.0/44 - 8*t) - 506.0/75*sin(9.0/26 - 5*t) + 16124.0/61*sin(t + 113.0/33) + 618.0/29*sin(2*t + 56.0/13) + 8587.0/318*sin(3*t + 65.0/41) + 522.0/43*sin(4*t + 117.0/46) + 141.0/22*sin(6*t + 22.0/31) + 101.0/63*sin(7*t + 109.0/33) + 94.0/63*sin(10*t + 63.0/22) + 58.0/37*sin(11*t + 55.0/13) + 61.0/60*sin(12*t + 25.0/38) - 89345.0/28)*theta(35*PI -t)*theta(t - 31*PI) + (9801.0/31*sin(t + 180.0/43) + 363.0/28*sin(2*t + 108.0/31) + 734.0/25*sin(3*t + 227.0/57) + 167.0/37*sin(4*t + 67.0/25) + 239.0/25*sin(5*t + 109.0/29) + 53.0/32*sin(6*t + 49.0/27) + 289.0/62*sin(7*t + 111.0/29) + 28.0/25*sin(8*t + 62.0/35) + 82.0/37*sin(9*t + 83.0/22) + 11.0/13*sin(10*t + 23.0/14) + 17.0/13*sin(11*t + 81.0/23) + 35.0/43*sin(12*t + 17.0/12) + 115816.0/67)*theta(31*PI -t)*theta(t - 27*PI) + (-11.0/20*sin(26.0/53 - 12*t) - 71.0/72*sin(9.0/31 - 10*t) - 19.0/14*sin(3.0/17 - 8*t) + 8779.0/26*sin(t + 47.0/11) + 239.0/23*sin(2*t + 39.0/20) + 2773.0/64*sin(3*t + 133.0/34) + 84.0/25*sin(4*t + 47.0/35) + 578.0/35*sin(5*t + 91.0/25) + 53.0/31*sin(6*t + 35.0/39) + 266.0/33*sin(7*t + 92.0/27) + 152.0/31*sin(9*t + 29.0/9) + 170.0/57*sin(11*t + 167.0/56) + 32191.0/9)*theta(27*PI -t)*theta(t - 23*PI) + (-31.0/43*sin(20.0/23 - 12*t) - 23.0/27*sin(31.0/42 - 10*t) + 4441.0/13*sin(t + 149.0/35) + 129.0/14*sin(2*t + 59.0/27) + 2773.0/64*sin(3*t + 134.0/35) + 106.0/35*sin(4*t + 12.0/13) + 484.0/29*sin(5*t + 67.0/19) + 19.0/10*sin(6*t + 20.0/37) + 127.0/15*sin(7*t + 62.0/19) + 23.0/24*sin(8*t + 1.0/17) + 221.0/47*sin(9*t + 47.0/16) + 133.0/44*sin(11*t + 97.0/37) - 30593.0/28)*theta(23*PI -t)*theta(t - 19*PI) + (-215.0/214*sin(8.0/15 - 12*t) - 40.0/29*sin(33.0/28 - 10*t) - 79.0/21*sin(51.0/103 - 4*t) - 965.0/18*sin(28.0/19 - 3*t) - 973.0/26*sin(61.0/62 - 2*t) - 7660.0/13*sin(31.0/21 -t) + 535.0/33*sin(5*t + 107.0/23) + 29.0/42*sin(6*t + 319.0/72) + 137.0/14*sin(7*t + 137.0/30) + 48.0/31*sin(8*t + 144.0/31) + 152.0/23*sin(9*t + 244.0/53) + 139.0/31*sin(11*t + 103.0/22) + 104533.0/24)*theta(19*PI -t)*theta(t - 15*PI) + (-1234.0/33*sin(44.0/41 - 12*t) - 1321.0/22*sin(29.0/21 - 9*t) - 26813.0/246*sin(37.0/34 - 7*t) - 3091.0/20*sin(47.0/37 - 5*t) - 805.0/6*sin(68.0/53 - 4*t) + 59867.0/49*sin(t + 79.0/41) + 16271.0/32*sin(2*t + 23.0/37) + 13093.0/43*sin(3*t + 29.0/11) + 1258.0/35*sin(6*t + 60.0/29) + 1347.0/17*sin(8*t + 86.0/19) + 1691.0/36*sin(10*t + 11.0/19) + 1259.0/74*sin(11*t + 47.0/11) - 3939.0/2)*theta(15*PI -t)*theta(t - 11*PI) + (-71.0/25*sin(52.0/73 - 24*t) - 589.0/64*sin(32.0/25 - 21*t) - 171.0/23*sin(32.0/53 - 19*t) - 817.0/50*sin(84.0/67 - 16*t) - 29*sin(23.0/26 - 14*t) - 868.0/37*sin(29.0/27 - 9*t) + 21649.0/24*sin(t + 57.0/35) + 38226.0/29*sin(2*t + 27.0/25) + 1282.0/17*sin(3*t + 125.0/47) + 1284.0/25*sin(4*t + 81.0/65) + 1687.0/31*sin(5*t + 16.0/21) + 2557.0/27*sin(6*t + 14.0/31) + 194.0/7*sin(7*t + 1.0/11) + 1051.0/26*sin(8*t + 26.0/19) + 1963.0/46*sin(10*t + 5.0/24) + 655.0/43*sin(11*t + 89.0/20) + 1091.0/35*sin(12*t + 3.0/23) + 439.0/40*sin(13*t + 67.0/23) + 210.0/31*sin(15*t + 55.0/27) + 1231.0/123*sin(17*t + 13.0/22) + 63.0/5*sin(18*t + 317.0/79) + 116.0/35*sin(20*t + 32.0/9) + 64.0/39*sin(22*t + 56.0/31) + 137.0/17*sin(23*t + 47.0/12) + 245.0/39*sin(25*t + 206.0/59) + 69.0/22*sin(26*t + 108.0/23) + 155.0/37*sin(27*t + 71.0/30) + 127.0/33*sin(28*t + 165.0/43) + 99.0/61*sin(29*t + 71.0/34) + 89.0/26*sin(30*t + 97.0/29) + 41.0/35*sin(31*t + 4.0/5) + 61.0/26*sin(32*t + 65.0/24) + 57.0/44*sin(33*t + 67.0/21) + 47.0/27*sin(34*t + 47.0/20) + 39.0/31*sin(35*t + 107.0/39) + 14.0/15*sin(36*t + 45.0/22) + 61.0/30*sin(37*t + 57.0/29) - 126637.0/39)*theta(11*PI -t)*theta(t - 7*PI) + (-173.0/27*sin(38.0/35 - 28*t) - 429.0/37*sin(1.0/36 - 24*t) - 169.0/22*sin(49.0/41 - 23*t) - 36.0/17*sin(3.0/22 - 16*t) - 299.0/22*sin(69.0/70 - 13*t) - 124.0/7*sin(11.0/14 - 12*t) - 2228.0/31*sin(18.0/71 - 9*t) - 1129.0/15*sin(35.0/24 - 8*t) - 197.0/5*sin(81.0/80 - 7*t) - 9403.0/82*sin(1.0/3 - 6*t) + 31022.0/33*sin(t + 79.0/21) + 24719.0/33*sin(2*t + 2.0/25) + 7576.0/21*sin(3*t + 47.0/12) + 7481.0/34*sin(4*t + 13.0/34) + 7221.0/23*sin(5*t + 16.0/17) + 2670.0/43*sin(10*t + 67.0/35) + 1157.0/53*sin(11*t + 66.0/23) + 761.0/55*sin(14*t + 50.0/37) + 170.0/13*sin(15*t + 25.0/11) + 483.0/53*sin(17*t + 95.0/33) + 271.0/25*sin(18*t + 127.0/32) + 241.0/39*sin(19*t + 32.0/25) + 454.0/29*sin(20*t + 44.0/19) + 593.0/57*sin(21*t + 5.0/3) + 209.0/24*sin(22*t + 29.0/16) + 247.0/62*sin(25*t + 127.0/85) + 219.0/82*sin(26*t + 130.0/33) + 1072.0/165*sin(27*t + 111.0/26) + 46.0/27*sin(29*t + 49.0/17) + 451.0/150*sin(30*t + 136.0/35) + 172.0/55*sin(31*t + 37.0/18) + 68.0/19*sin(32*t + 63.0/20) + 48878.0/43)*theta(7*PI -t)*theta(t - 3*PI) + (-354.0/35*sin(21.0/29 - 24*t) - 400.0/57*sin(29.0/23 - 22*t) - 407.0/39*sin(25.0/24 - 13*t) - 1129.0/25*sin(14.0/17 - 12*t) - 939.0/16*sin(35.0/29 - 11*t) - 2603.0/34*sin(2.0/15 - 10*t) - 643.0/27*sin(86.0/57 - 9*t) - 2676.0/25*sin(11.0/14 - 7*t) - 11063.0/56*sin(8.0/29 - 6*t) + 15888.0/23*sin(t + 55.0/19) + 56918.0/65*sin(2*t + 63.0/47) + 7453.0/40*sin(3*t + 1.0/25) + 6765.0/31*sin(4*t + 73.0/35) + 5584.0/21*sin(5*t + 61.0/16) + 5407.0/81*sin(8*t + 171.0/43) + 271.0/17*sin(14*t + 33.0/19) + 311.0/24*sin(15*t + 19.0/33) + 310.0/19*sin(16*t + 290.0/63) + 419.0/25*sin(17*t + 92.0/21) + 203.0/23*sin(18*t + 28.0/31) + 627.0/29*sin(19*t + 113.0/30) + 446.0/37*sin(20*t + 61.0/25) + 347.0/34*sin(21*t + 17.0/44) + 311.0/17*sin(23*t + 212.0/47) + 429.0/29*sin(25*t + 85.0/24) + 112.0/11*sin(26*t + 46.0/39) + 53.0/19*sin(27*t + 37.0/8) + 71443.0/23)*theta(3*PI -t)*theta(t +PI))*theta(sqrt(sgn(sin(t/2))));
}

float y(float t)
{
  return ((-6.0/49*sin(14.0/11 - 12*t) - 47.0/95*sin(7.0/13 - 11*t) - 4.0/35*sin(40.0/33 - 8*t) - 36.0/19*sin(11.0/18 - 7*t) - 1.0/7*sin(4.0/3 - 4*t) - 399.0/29*sin(12.0/17 - 3*t) + 4987.0/33*sin(t + 87.0/22) + 45.0/29*sin(2*t + 2.0/31) + 125.0/18*sin(5*t + 65.0/16) + 10.0/19*sin(6*t + 11.0/50) + 47.0/20*sin(9*t + 121.0/29) + 7.0/24*sin(10*t + 9.0/22) + 14377.0/30)*theta(51*PI -t)*theta(t - 47*PI) + (-4432.0/21*sin(65.0/44 -t) + 290.0/31*sin(2*t + 4.0/21) + 115.0/16*sin(3*t + 108.0/23) + 221.0/30*sin(4*t + 21.0/53) + 8.0/19*sin(5*t + 11.0/31) + 111.0/40*sin(6*t + 4.0/11) + 37.0/23*sin(7*t + 45.0/26) + 17.0/25*sin(8*t + 37.0/39) + 38.0/35*sin(9*t + 37.0/18) + 11.0/23*sin(10*t + 97.0/30) + 17.0/45*sin(11*t + 98.0/41) + 13.0/29*sin(12*t + 135.0/38) + 4649.0/16)*theta(47*PI -t)*theta(t - 43*PI) + (-97.0/37*sin(5.0/31 - 6*t) - 103.0/52*sin(16.0/15 - 5*t) - 174.0/25*sin(4.0/15 - 4*t) - 274.0/39*sin(6.0/11 - 2*t) - 8758.0/39*sin(55.0/36 -t) + 377.0/36*sin(3*t + 155.0/34) + 22.0/27*sin(7*t + 17.0/60) + 23.0/16*sin(8*t + 1.0/7) + 17.0/32*sin(9*t + 10.0/23) + 107.0/160*sin(10*t + 35.0/41) + 37.0/75*sin(11*t + 46.0/51) + 11.0/36*sin(12*t + 31.0/25) - 1881.0/4)*theta(43*PI -t)*theta(t - 39*PI) + (-26.0/17*sin(17.0/13 - 9*t) + 7121.0/22*sin(t + 173.0/38) + 457.0/19*sin(2*t + 70.0/23) + 148.0/7*sin(3*t + 46.0/11) + 3389.0/226*sin(4*t + 79.0/35) + 275.0/41*sin(5*t + 212.0/49) + 157.0/20*sin(6*t + 48.0/31) + 81.0/31*sin(7*t + 21.0/5) + 87.0/32*sin(8*t + 61.0/48) + 27.0/14*sin(10*t + 17.0/12) + 171.0/86*sin(11*t + 108.0/23) + 23.0/18*sin(12*t + 17.0/16) - 34203.0/35)*theta(39*PI -t)*theta(t - 35*PI) + (-94.0/41*sin(28.0/19 - 11*t) - 90.0/47*sin(40.0/41 - 9*t) + 12001.0/37*sin(t + 140.0/31) + 1376.0/55*sin(2*t + 179.0/56) + 587.0/28*sin(3*t + 78.0/19) + 277.0/15*sin(4*t + 62.0/27) + 232.0/39*sin(5*t + 31.0/7) + 429.0/47*sin(6*t + 49.0/32) + 47.0/22*sin(7*t + 159.0/38) + 255.0/73*sin(8*t + 30.0/31) + 39.0/22*sin(10*t + 49.0/37) + 34.0/31*sin(12*t + 32.0/33) - 3589.0/17)*theta(35*PI -t)*theta(t - 31*PI) + (-1073.0/27*sin(53.0/35 - 3*t) - 1183.0/3*sin(63.0/47 -t) + 134.0/19*sin(2*t + 1.0/20) + 65.0/33*sin(4*t + 19.0/18) + 328.0/27*sin(5*t + 172.0/37) + 53.0/21*sin(6*t + 11.0/12) + 361.0/56*sin(7*t + 233.0/51) + 19.0/14*sin(8*t + 77.0/64) + 129.0/38*sin(9*t + 157.0/35) + 34.0/33*sin(10*t + 36.0/23) + 49.0/29*sin(11*t + 183.0/43) + 59.0/53*sin(12*t + 80.0/57) + 33002.0/47)*theta(31*PI -t)*theta(t - 27*PI) + (-7.0/19*sin(27.0/43 - 10*t) - 23.0/27*sin(29.0/31 - 8*t) - 24.0/49*sin(40.0/31 - 6*t) - 41.0/28*sin(30.0/29 - 4*t) - 1519.0/32*sin(32.0/21 - 3*t) - 267.0/25*sin(51.0/46 - 2*t) - 2347.0/5*sin(35.0/24 -t) + 323.0/21*sin(5*t + 47.0/10) + 119.0/18*sin(7*t + 79.0/17) + 363.0/91*sin(9*t + 115.0/26) + 54.0/23*sin(11*t + 147.0/34) + 8.0/45*sin(12*t + 2.0/25) - 3942.0/5)*theta(27*PI -t)*theta(t - 23*PI) + (-7.0/30*sin(6.0/19 - 12*t) - 11.0/27*sin(61.0/41 - 8*t) - 27.0/25*sin(49.0/43 - 6*t) - 145.0/78*sin(45.0/32 - 4*t) - 630.0/71*sin(23.0/26 - 2*t) - 11383.0/24*sin(3.0/2 -t) + 1804.0/37*sin(3*t + 221.0/47) + 682.0/45*sin(5*t + 114.0/25) + 220.0/31*sin(7*t + 127.0/29) + 142.0/39*sin(9*t + 71.0/17) + 13.0/43*sin(10*t + 221.0/49) + 44.0/21*sin(11*t + 139.0/36) - 952.0/27)*theta(23*PI -t)*theta(t - 19*PI) + (-156.0/19*sin(31.0/22 - 7*t) + 8161.0/26*sin(t + 79.0/18) + 551.0/8*sin(2*t + 107.0/51) + 1301.0/27*sin(3*t + 122.0/29) + 157.0/22*sin(4*t + 89.0/37) + 437.0/22*sin(5*t + 73.0/16) + 99.0/28*sin(6*t + 20.0/39) + 172.0/39*sin(8*t + 35.0/37) + 47.0/16*sin(9*t + 175.0/38) + 115.0/37*sin(10*t + 25.0/17) + 65.0/22*sin(11*t + 163.0/40) + 35.0/26*sin(12*t + 50.0/27) + 30125.0/33)*theta(19*PI -t)*theta(t - 15*PI) + (-1139.0/44*sin(21.0/29 - 12*t) - 3787.0/36*sin(43.0/28 - 9*t) - 20129.0/76*sin(46.0/39 - 5*t) + 11777.0/25*sin(t + 57.0/16) + 7005.0/28*sin(2*t + 77.0/45) + 8944.0/33*sin(3*t + 133.0/43) + 849.0/10*sin(4*t + 127.0/39) + 67.0/5*sin(6*t + 70.0/27) + 1002.0/7*sin(7*t + 7.0/26) + 2129.0/23*sin(8*t + 61.0/14) + 647.0/11*sin(10*t + 37.0/25) + 1221.0/25*sin(11*t + 78.0/17) - 2950.0/23)*theta(15*PI -t)*theta(t - 11*PI) + (-100.0/21*sin(32.0/31 - 32*t) - 37.0/7*sin(1.0/3 - 30*t) - 67.0/21*sin(55.0/82 - 29*t) - 25.0/43*sin(29.0/24 - 21*t) - 43.0/18*sin(99.0/79 - 20*t) - 3578.0/53*sin(18.0/31 - 7*t) + 21154.0/15*sin(t + 239.0/54) + 10453.0/21*sin(2*t + 31.0/25) + 2369.0/21*sin(3*t + 32.0/35) + 8835.0/41*sin(4*t + 110.0/31) + 1153.0/20*sin(5*t + 115.0/31) + 1364.0/21*sin(6*t + 29.0/11) + 418.0/9*sin(8*t + 32.0/15) + 1201.0/28*sin(9*t + 283.0/66) + 62.0/3*sin(10*t + 122.0/65) + 4253.0/107*sin(11*t + 218.0/53) + 133.0/36*sin(12*t + 62.0/43) + 1127.0/38*sin(13*t + 73.0/25) + 279.0/26*sin(14*t + 52.0/31) + 1079.0/59*sin(15*t + 83.0/33) + 22.0/5*sin(16*t + 51.0/37) + 382.0/33*sin(17*t + 71.0/53) + 239.0/31*sin(18*t + 7.0/13) + 155.0/42*sin(19*t + 17.0/20) + 72.0/43*sin(22*t + 87.0/19) + 56.0/25*sin(23*t + 53.0/23) + 115.0/22*sin(24*t + 9.0/4) + 37.0/12*sin(25*t + 31.0/24) + 113.0/24*sin(26*t + 41.0/30) + 140.0/39*sin(27*t + 2.0/19) + 944.0/149*sin(28*t + 9.0/13) + 127.0/52*sin(31*t + 123.0/29) + 36.0/23*sin(33*t + 61.0/20) + 62.0/21*sin(34*t + 75.0/17) + 37.0/17*sin(35*t + 59.0/32) + 123.0/74*sin(36*t + 32.0/9) + 29.0/12*sin(37*t + 3.0/17) - 18711.0/40)*theta(11*PI -t)*theta(t - 7*PI) + (-426.0/31*sin(12.0/31 - 23*t) - 1001.0/100*sin(4.0/31 - 19*t) - 245.0/23*sin(5.0/37 - 13*t) - 437.0/29*sin(41.0/48 - 9*t) - 1698.0/11*sin(28.0/33 - 8*t) - 4699.0/28*sin(10.0/7 - 7*t) - 68398.0/117*sin(50.0/39 - 3*t) + 33209.0/30*sin(t + 73.0/19) + 3249.0/16*sin(2*t + 90.0/91) + 3906.0/25*sin(4*t + 37.0/8) + 7226.0/39*sin(5*t + 35.0/52) + 4533.0/31*sin(6*t + 19.0/25) + 2999.0/41*sin(10*t + 59.0/15) + 149.0/19*sin(11*t + 157.0/57) + 1075.0/42*sin(12*t + 53.0/22) + 245.0/24*sin(14*t + 5.0/3) + 131.0/19*sin(15*t + 15.0/14) + 168.0/11*sin(16*t + 9.0/10) + 80.0/9*sin(17*t + 36.0/35) + 71.0/36*sin(18*t + 205.0/68) + 151.0/23*sin(20*t + 11.0/9) + 425.0/42*sin(21*t + 57.0/40) + 111.0/29*sin(22*t + 65.0/29) + 50.0/11*sin(24*t + 9.0/19) + 152.0/17*sin(25*t + 73.0/16) + 13.0/19*sin(26*t + 61.0/14) + 68.0/11*sin(27*t + 51.0/16) + 422.0/169*sin(28*t + 122.0/37) + 37.0/24*sin(29*t + 31.0/15) + 104.0/55*sin(30*t + 74.0/29) + 48.0/35*sin(31*t + 20.0/23) + 14.0/3*sin(32*t + 20.0/11) + 1325.0/23)*theta(7*PI -t)*theta(t - 3*PI) + (-73.0/30*sin(55.0/42 - 26*t) - 2657.0/161*sin(14.0/37 - 24*t) - 272.0/13*sin(100.0/67 - 23*t) - 591.0/29*sin(54.0/35 - 16*t) - 808.0/13*sin(51.0/47 - 13*t) - 855.0/13*sin(83.0/58 - 12*t) - 1793.0/30*sin(27.0/26 - 11*t) - 5991.0/29*sin(1.0/19 - 7*t) - 3268.0/31*sin(29.0/51 - 6*t) + 30189.0/31*sin(t + 161.0/38) + 5914.0/15*sin(2*t + 119.0/65) + 3830.0/37*sin(3*t + 122.0/31) + 4667.0/19*sin(4*t + 68.0/33) + 4693.0/15*sin(5*t + 95.0/24) + 2861.0/24*sin(8*t + 169.0/38) + 457.0/14*sin(9*t + 61.0/43) + 1475.0/17*sin(10*t + 86.0/115) + 1759.0/43*sin(14*t + 79.0/28) + 1452.0/41*sin(15*t + 37.0/62) + 3125.0/71*sin(17*t + 152.0/33) + 505.0/51*sin(18*t + 57.0/20) + 585.0/23*sin(19*t + 48.0/11) + 382.0/17*sin(20*t + 93.0/41) + 264.0/37*sin(21*t + 257.0/258) + 1299.0/118*sin(22*t + 37.0/15) + 407.0/18*sin(25*t + 205.0/48) + 367.0/26*sin(27*t + 43.0/11) - 5384.0/13)*theta(3*PI -t)*theta(t +PI))*theta(sqrt(sgn(sin(t/2))));
}
