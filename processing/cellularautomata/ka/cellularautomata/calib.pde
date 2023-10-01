class St
{
  int h, s, b; // 360 x 100 x 100

  St(int hh, int ss, int bb)
  {
    h=hh;
    s=ss;
    b=bb;
  }

  color getcolor()
  {
    return color(h, s, b);
  }
}

class C
{
  color c1, c0;
  float side, x, y;
  C l, r, u, d;
  St state, nextstate;
  String type;

  C(float xx, float yy, float s, String tp)
  {
    this.c1=on;
    this.c0=off;
    side=s;
    x=xx;
    y=yy;
    type=tp;
    l=r=u=d=null;
    if (random(1)>0.5)
    {
      nextstate=state=new St(180, 80, 80);
    } else
    {
      nextstate=state=new St(0, 80, 80);
    }
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

C extendx(C col, float sd, String typ)
{
  C hd=col, p=col;
  float mx=sd;

  // initial node
  C tl=new C(hd.x+mx, hd.y, sd, typ);
  hd.r=tl;
  tl.l=hd;
  clist.add(tl);
  p=p.d;

  // rest of the nodes
  while (p!=null)
  {
    C tmp=new C(p.x+mx, p.y, sd, typ);
    p.r=tmp;
    tmp.l=p;
    tmp.u=tl;
    tl.d=tmp;
    tl=tmp;
    clist.add(tmp);
    p=p.d;
  }

  return hd.r;
}

C extendy(C row, float sd, String typ)
{
  C hd=row, p=row;
  float my=sd;

  // initial node
  C tl=new C(hd.x, hd.y+my, sd, typ);
  hd.d=tl;
  tl.u=hd;
  clist.add(tl);
  p=p.r;

  // rest of the nodes
  while (p!=null)
  {
    C tmp=new C(p.x, p.y+my, sd, typ);
    p.d=tmp;
    tmp.u=p;
    tmp.l=tl;
    tl.r=tmp;
    tl=tmp;
    clist.add(tmp);
    p=p.r;
  }

  return hd.d;
}

C buildx(float x, float y, int n, float sd, String typ)
{
  C head=null, p=null;
  float mx=sd, my=sd;
  for (int i=0; i<n; i++)
  {
    if (head==null)
    {
      head=new C(x, y, sd, typ);
      p=head;
    } else
    {
      C tmp=new C(x+mx*i, y, sd, typ);
      p.r=tmp;
      tmp.l=p;
      p=tmp;
    }
    clist.add(p);
  }
  return head;
}

void stitchlr(C lhd, C rhd)
{
  C p=lhd;
  while (p.r!=null)p=p.r;
  for (C q=rhd; p!=null && q!=null; p=p.d, q=q.d)
  {
    p.r=q;
    q.l=p;
  }
}

void stitchud(C uhd, C dhd)
{
  C p=uhd;
  while (p.d!=null)p=p.d;
  for (C q=dhd; p!=null && q!=null; p=p.r, q=q.r)
  {
    p.d=q;
    q.u=p;
  }
}

C buildgrid(float x, float y, int m, int n, float sd, String typ)
{
  C head=buildx(x, y, n, sd, typ);
  C p=head;
  for (int i=1; i<m; i++)
  {
    p=extendy(p, sd, typ);
  }
  return head;
}

void growgridright(C hd, String typ, int m)
{
  C p=hd;
  while (p.r!=null)p=p.r;
  for (int i=0; i<m; i++)
  {
    p=extendx(p, hd.side, typ);
  }
}

void growgriddown(C hd, String typ, int m)
{
  C p=hd;
  while (p.d!=null)p=p.d;
  for (int i=0; i<m; i++)
  {
    p=extendy(p, hd.side, typ);
  }
}

void rndrrow(C hd, PGraphics z)
{
  C p=hd;
  for (int visits=0;; p=p.r)
  {
    if (p==hd)visits+=1;
    if (visits>=2)break;
    p.rndr(z);
  }
}

void rndrgrid(C hd, PGraphics z)
{
  C p=hd;
  for (int visits=0;; p=p.d)
  {
    if (p==hd)visits+=1;
    if (visits>=2)break;
    rndrrow(p, z);
  }
}

void rules4type(C c)
{
  float r=random(1);
  switch(c.type)
  {
  case "air":
    air01(c, r);
    break;
  case "water":
    water00(c, r);
    break;
  case "ether":
    ether00(c, r);
    break;
  case "fire":
    fire00(c, r);
    break;
  }
}

void evalrules()
{
  // first sweep generate next states
  for (C c : clist)
  {
    if (c.u==null)continue;
    if (c.d==null)continue;
    if (c.l==null)continue;
    if (c.r==null)continue;
    // rule
    rules4type(c);
  }
  // second sweep update the grid
  for (C c : clist)
  {
    c.state=c.nextstate;
  }
}

void randomize()
{
  for (C c : clist)
  {
    switch(c.type)
    {
    case "air":
      c.nextstate.h=c.state.h=round(random(0, 90));
      c.nextstate.b=c.state.b=100;
      c.nextstate.s=c.state.s=100;
      break;
    case "water":
      c.nextstate.h=c.state.h=round(random(90, 180));
      c.nextstate.b=c.state.b=100;
      c.nextstate.s=c.state.s=100;
      break;
    case "ether":
      c.nextstate.h=c.state.h=round(random(180, 270));
      c.nextstate.b=c.state.b=100;
      c.nextstate.s=c.state.s=100;
      break;
    case "fire":
      c.nextstate.h=c.state.h=round(random(270, 360));
      c.nextstate.b=c.state.b=100;
      c.nextstate.s=c.state.s=100;
      break;
    }
  }
}
