C ca;
color on, off;
ArrayList<C> clist;
ArrayList<String> typelist;
PGraphics pg;
boolean recording=false;

void setuptypes()
{
  typelist=new ArrayList<>();
  typelist.add("air");
  typelist.add("water");
  typelist.add("ether");
  typelist.add("fire");
}

void setupcanvas()
{
  pg=createGraphics(1280, 720);
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
  on=color(120, 100, 100);
  off=color(120+180, 100, 100);
  clist=new ArrayList<>();
  ca=buildgrid(10, 10, 190, 315, 2, typelist.get(0));
  growgridright(ca, typelist.get(1), 315);
  C ca2=buildgrid(10, 330, 190, 315, 2, typelist.get(2));
  growgridright(ca2, typelist.get(3), 315);
  stitchud(ca, ca2);
  wiretorus();
}

void setup()
{
  size(1280, 720);
  colorMode(HSB, 360, 100, 100);
  frameRate(30);
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
    save(String.format("img/ca_%05d.jpg", frameCount));
  }
  evalrules();
}

void mouseClicked()
{
  for (C c : clist)
  {
    if (c.x<mouseX && c.y<mouseY && c.x+c.side>mouseX && c.y+c.side>mouseY)
    {
      c.nextstate.h=360-c.state.h;
    }
  }
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
