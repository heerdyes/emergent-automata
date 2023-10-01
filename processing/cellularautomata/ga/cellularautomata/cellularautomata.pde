import java.util.HashSet;

C ca;
color on, off;
ArrayList<C> clist;
ArrayList<String> typelist;
PGraphics pg;
boolean recording=false;

void setuptypes()
{
  typelist=new ArrayList<>();
  typelist.add("earth");
}

void setupcanvas()
{
  pg=createGraphics(1600, 1600);
  pg.colorMode(HSB, 360, 100, 100);
  pg.beginDraw();
  pg.background(0, 0, 0);
  pg.endDraw();
}

void wiretorus()
{
  C itail=ca, ihead=ca;
  // travel downwards linking leftmost and rightmost cols
  while (itail.r!=null)itail=itail.r;
  while (true)
  {
    ihead.l=itail;
    itail.r=ihead;
    if (ihead.d==null || itail.d==null)break;
    ihead=ihead.d;
    itail=itail.d;
  }
  C jhead=ca, jtail=ihead;
  // travel rightwards linking topmost and bottommost cols
  while (true)
  {
    jhead.u=jtail;
    jtail.d=jhead;
    if (jtail==itail)break;
    jhead=jhead.r;
    jtail=jtail.r;
  }
}

void setupgrid()
{
  clist=new ArrayList<>();
  int qs=400;
  ca=buildgrid(0, 0, qs, qs, 1600/qs, typelist.get(0));
  wiretorus();
}

void setup()
{
  size(800, 800);
  colorMode(HSB, 360, 100, 100);
  //frameRate(10);
  setupcanvas();
  setuptypes();
  setupgrid(); // prerequisite is setuptypes
  randomize();
}

void draw()
{
  pg.beginDraw();
  rndrgrid(ca, pg);
  pg.endDraw();
  image(pg, 0, 0, width, height);
  if (recording)
  {
    pg.save(String.format("img/ca_%05d.jpg", frameCount));
  }
  if (frameCount%1000==0)
  {
    println(frameCount);
  }
  evalrules();
}

void keyPressed()
{
  if (key=='r')
  {
    randomize();
  } else if (key=='.')
  {
    recording=!recording;
  }
}
