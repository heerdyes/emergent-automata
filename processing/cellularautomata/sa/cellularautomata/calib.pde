class St
{
  int h, s, b; // 360 x 100 x 100
  String t;    // type

  St(int hh, int ss, int bb, String tp)
  {
    h=hh;
    s=ss;
    b=bb;
    t=tp;
  }

  color getcolor()
  {
    return color(h, s, b);
  }
}

class C
{
  float side, x, y;
  C l, r, u, d;
  St state, nextstate;

  C(float xx, float yy, float s, String tp)
  {
    side=s;
    x=xx;
    y=yy;
    l=r=u=d=null;
    nextstate=state=new St(180, 100, 100, tp);
  }

  String lpad(String s, char c, int n)
  {
    if (s.length()>=n)
    {
      return s;
    }
    int d=n-s.length();
    StringBuffer sb=new StringBuffer();
    for (int i=0; i<d; i++)
    {
      sb.append(c);
    }
    sb.append(s);
    return sb.toString();
  }

  void rndr(PGraphics _g)
  {
    _g.noStroke();
    _g.fill(state.getcolor());
    _g.rect(x, y, side, side);
  }
}
