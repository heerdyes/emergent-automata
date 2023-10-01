void stairs(C c)
{
  if (c.state.h==60 && c.l.state.h==120)
  {
    c.nextstate.h=120;
  } else if (c.state.h==120 && c.r.state.h==60)
  {
    c.nextstate.h=60;
  } else if (c.state.h==120 && c.u.state.h==60)
  {
    c.nextstate.h=60;
  } else if (c.state.h==60 && c.d.state.h==120)
  {
    c.nextstate.h=120;
  }
}

void nightlights(C c)
{
  if (c.state.h==60 && c.u.state.h==60)
  {
    c.nextstate.h=120;
    if (c.state.b==0)
    {
      c.nextstate.b=50;
    } else
    {
      c.nextstate.b=round(1.08*c.state.b)%100;
    }
  } else if (c.state.h==120 && c.d.state.h==120)
  {
    c.nextstate.h=60;
    if (c.state.b==0)
    {
      c.nextstate.b=50;
    } else
    {
      c.nextstate.b=round(1.08*c.state.b)%100;
    }
  } else if (c.state.h==60 && c.l.state.h==120)
  {
    c.nextstate.h=120;
    c.nextstate.b=round(c.state.b*0.94);
  } else if (c.state.h==120 && c.r.u.state.h==60)
  {
    c.nextstate.h=60;
    c.nextstate.b=round(c.state.b*0.94);
  }
}

int choose(float rlim, int a, int b)
{
  if (random(1)<rlim)
  {
    return a;
  }
  return b;
}

int[][] nbhd(C c)
{
  int v11=c.l.u.state.h;
  int v12=c.u.state.h;
  int v13=c.r.u.state.h;
  int v21=c.l.state.h;
  int v22=c.state.h;
  int v23=c.r.state.h;
  int v31=c.l.d.state.h;
  int v32=c.d.state.h;
  int v33=c.r.d.state.h;
  int v[][]=new int[][] {
    {v11, v12, v13},
    {v21, v22, v23},
    {v31, v32, v33}
  };
  return v;
}

void tmp(C c)
{
  int v[][]=nbhd(c);
  int r_0_180=0, r_180_360=0;
  for (int i=0; i<3; i++)
  {
    for (int j=0; j<3; j++)
    {
      if (i==1 && j==1)continue;
      if (v[i][j]<=180)
      {
        r_0_180+=1;
      } else
      {
        r_180_360+=1;
      }
    }
  }
  int candidate;
  if (r_180_360>5 || r_180_360<2 && c.state.h>180)
  {
    candidate=c.state.h/2;
  } else if (r_180_360>=2 && r_180_360<=3 && c.state.h<=180)
  {
    candidate=c.state.h*2;
  } else
  {
    candidate=c.state.h+round(20*sin(radians(frameCount)));
  }
  if (candidate>360)
  {
    candidate=180+floor(random(180));
  } else if (candidate<0)
  {
    candidate=floor(random(180));
  }
  c.nextstate.h=candidate;
}

void warmocean(C c)
{
  if (frameCount%2==0)
  {
    c.nextstate.h=(c.l.state.h+c.r.state.h)/2;
  } else
  {
    int diff=(c.u.state.h-c.d.state.h)/2;
    int ns=c.state.h-diff;
    c.nextstate.h=ns<=0?240:ns;
  }
}

void golish(C c)
{
  int v11=c.l.u.state.h;
  int v12=c.u.state.h;
  int v13=c.r.u.state.h;
  int v21=c.l.state.h;
  int v22=c.state.h;
  int v23=c.r.state.h;
  int v31=c.l.d.state.h;
  int v32=c.d.state.h;
  int v33=c.r.d.state.h;
  int v[][]=new int[][] {
    {v11, v12, v13},
    {v21, v22, v23},
    {v31, v32, v33}
  };
  int ctr60=0, ctr120=0;
  for (int i=0; i<3; i++)
  {
    for (int j=0; j<3; j++)
    {
      if (v[i][j]==60)
      {
        ctr60+=1;
      } else if (v[i][j]==120)
      {
        ctr120+=1;
      }
    }
  }
  if (ctr120<2 && v22==120)
  {
    c.nextstate.h=60;
  } else if (ctr120>6 && v22==120)
  {
    c.nextstate.h=60;
  } else if (ctr120>=4 && ctr120<=6 && v22==60)
  {
    c.nextstate.h=120;
  }
}
