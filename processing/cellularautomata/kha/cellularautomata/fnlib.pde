String[] elements=new String[]{"air", "water", "fire", "ether"};

void air00(C c, float r)
{
  if (c.state.h==90)
  {
    c.nextstate.h=c.state.h*3;
    c.nextstate.t="water";
  } else if (c.state.h>300)
  {
    c.nextstate.h=180;
    c.nextstate.t="ether";
  } else {
    c.nextstate.h=c.state.h-1;
  }
}

void water00(C c, float r)
{
  if (c.state.h>300)
  {
    c.nextstate.h=120;
  }
}

void ether00(C c, float r)
{
  if (c.state.h<=0)
  {
    c.nextstate.h=359;
  } else
  {
    c.nextstate.h=c.state.h-1;
  }
  c.nextstate.t=elements[floor(r*4)];
}

void fire00(C c, float r)
{
  if (c.state.h<=0)
  {
    c.nextstate.h=359;
  } else
  {
    c.nextstate.h=c.state.h-2;
  }
  c.nextstate.t=elements[floor(r*4)];
}
