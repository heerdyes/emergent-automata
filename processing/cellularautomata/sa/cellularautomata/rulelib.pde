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

void applykernel(C c, int[][] v)
{
  c.l.u.nextstate.h=v[0][0];
  c.u.nextstate.h=v[0][1];
  c.r.u.nextstate.h=v[0][2];
  c.l.nextstate.h=v[1][0];
  c.nextstate.h=v[1][1];
  c.r.nextstate.h=v[1][2];
  c.l.d.nextstate.h=v[2][0];
  c.d.nextstate.h=v[2][1];
  c.r.d.nextstate.h=v[2][2];
}

void tmp(C c)
{
  int v[][]=nbhd(c);
  float krnl[][]=new float[][]{
    {1, 1, 1},
    {1, 2, 1},
    {1, 4, 1}
  };
  for (int i=0; i<3; i++)
  {
    for (int j=0; j<3; j++)
    {
      int candidate=round(v[i][j]*krnl[i][j]);
      if (candidate<0)
      {
        candidate=360+candidate;
      } else if (candidate>=360)
      {
        candidate=candidate%360;
      }
      v[i][j]=candidate;
    }
  }
  applykernel(c, v);
}
