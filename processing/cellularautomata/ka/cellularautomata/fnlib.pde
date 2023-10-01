int probavg00(C c)
{
  float r1=random(1);
  float v;
  if (r1>0.1)
  {
    v=(c.l.state.h+c.r.state.h)/2;
  } else if (r1>0.025 && r1<=0.1)
  {
    v=(c.d.r.state.h+c.u.l.state.h)/2;
  } else
  {
    v=(c.u.state.h*c.d.state.h)%360;
  }
  return round(v);
}

int probavg01(C c)
{
  float r2=random(1);
  float v;
  if (r2>0.1)
  {
    v=(c.d.state.h+c.u.state.h)/2;
  } else if (r2>0.02 && r2<=0.1)
  {
    v=(c.d.r.state.h+c.u.l.state.h)/2;
  } else
  {
    v=(c.l.state.h*c.r.state.h)%360;
  }
  return round(v);
}

int noisychoice(C c, int fixed)
{
  int v;
  if (random(1)>0.999)
  {
    v=round(random(360));
  } else
  {
    if (c.d.state.h==fixed)v=random(1)>0.33 ? c.d.state.h : round(random(c.d.state.h-4, c.d.state.h+4));
    else {
      if (random(1)>0.66)
      {
        v=(c.l.state.h+c.r.state.h+c.l.u.state.h)/3+round(random(-3, 3));
      } else
      {
        v=(c.l.state.h+c.r.state.h+c.r.d.state.h)/3+round(random(-3, 3));
      }
    }
  }
  return v;
}

int noisychoice(int fixed)
{
  return fixed+round(random(-10, 10));
}

void air00(C c, float r)
{
  if (r>0.85)c.nextstate.h=(c.l.u.state.h+c.r.d.state.h)/2;
  else if (r<0.1)c.nextstate.h=(c.r.state.h+c.l.state.h)/2;
  else if (r<0.11)c.type="water";
  else if (r<0.12)c.type="ether";
  else if (r<0.13)c.type="fire";
  else c.nextstate.h=c.state.h+1%360;
}

void air01(C c, float r)
{
  if (r>0.85)c.nextstate.h=(c.u.state.h+c.state.h+c.d.r.state.h)/3;
  else if (r<0.1)c.nextstate.h=(c.r.state.h+c.l.state.h)/2;
  else if (r<0.11)c.type="water";
  else if (r<0.12)c.type="ether";
  else if (r<0.13)c.type="fire";
  else c.nextstate.h=c.state.h+1%360;
}

void water00(C c, float r)
{
  if (r>0.05)
  {
    if (random(1)<0.5)
    {
      c.nextstate.h=(c.r.state.h+c.l.state.h)/2;
    } else {
      if (c.l.state.h<45 && c.state.h<45)
      {
        c.nextstate.h=c.state.h+c.l.state.h;
      } else if (c.u.state.h>=180 && c.d.state.h>=180)
      {
        c.nextstate.h=round(270+random(-10, 10));
      } else
      {
        c.nextstate.h=c.r.state.h;
      }
    }
  } else if (r<0.03)c.nextstate.h=abs(c.state.h-c.l.l.state.h);
  else if (r<0.032)c.type="ether";
  else if (r<0.034)c.type="air";
  else if (r<0.036)c.type="fire";
  else c.nextstate.h=round(sq(c.state.h-1))%360;
}

void ether00(C c, float r)
{
  if (r>0.05)c.nextstate.h=(c.r.u.state.h+c.l.d.state.h)/2;
  else if (r<0.02)c.nextstate.h=(c.l.l.state.h+c.r.r.state.h)/2;
  else if (r<0.022)c.type="air";
  else if (r<0.024)c.type="water";
  else if (r<0.026)c.type="fire";
  else c.nextstate.h=c.state.h*2%360;
}

void fire00(C c, float r)
{
  if (r>0.51)
  {
    if (r>0.75)
    {
      c.nextstate.h=(c.l.state.h+c.r.state.h+c.u.state.h)/3;
    } else
    {
      c.nextstate.h=(c.l.state.h+c.state.h+c.r.state.h+c.d.state.h)/4;
    }
  } else if (r>0.02)
  {
    if (r<0.25)
    {
      c.nextstate.h=(c.u.state.h+c.state.h+c.d.state.h+c.l.state.h)/4;
    } else
    {
      c.nextstate.h=(c.u.state.h+c.d.state.h+c.r.state.h)/3;
    }
  } else
  {
    int r2=round(random(4));
    switch(r2)
    {
    case 0:
      c.type="air";
      break;
    case 1:
      c.type="water";
      break;
    case 2:
      c.type="ether";
      break;
    case 3:
      c.type="fire";
      break;
    }
  }
}
