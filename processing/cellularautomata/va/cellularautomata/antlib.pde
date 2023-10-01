class Ant
{
  C pos;
  char dir;

  Ant(C x)
  {
    pos=x;
    switch(floor(random(8)))
    {
    case 0:
      dir='u';
      break;
    case 1:
      dir='d';
      break;
    case 2:
      dir='l';
      break;
    case 3:
      dir='r';
      break;
    case 4:
      dir='t';
      break;
    case 5:
      dir='e';
      break;
    case 6:
      dir='c';
      break;
    case 7:
      dir='v';
      break;
    }
  }

  void step()
  {
    switch(dir)
    {
    case 'u':
      pos=pos.u;
      break;
    case 'd':
      pos=pos.d;
      break;
    case 'l':
      pos=pos.l;
      break;
    case 'r':
      pos=pos.r;
      break;
    case 't':
      pos=pos.u.l;
      break;
    case 'e':
      pos=pos.d.r;
      break;
    case 'c':
      pos=pos.l.d;
      break;
    case 'v':
      pos=pos.r.u;
      break;
    }
  }

  void turnleft()
  {
    switch(dir)
    {
    case 'u':
      dir='t';
      break;
    case 'd':
      dir='e';
      break;
    case 'l':
      dir='c';
      break;
    case 'r':
      dir='v';
      break;
    case 't':
      dir='l';
      break;
    case 'e':
      dir='r';
      break;
    case 'c':
      dir='d';
      break;
    case 'v':
      dir='u';
      break;
    }
  }

  void turnright()
  {
    switch(dir)
    {
    case 'u':
      dir='v';
      break;
    case 'd':
      dir='c';
      break;
    case 'l':
      dir='t';
      break;
    case 'r':
      dir='e';
      break;
    case 't':
      dir='u';
      break;
    case 'e':
      dir='d';
      break;
    case 'c':
      dir='l';
      break;
    case 'v':
      dir='r';
      break;
    }
  }

  void exist()
  {
    step();
    float r=random(1);
    if (pos.state.h==0)
    {
      pos.nextstate.h=90;
      turnleft();
    } else if (pos.state.h==45)
    {
      pos.nextstate.h=135;
      turnright();
    } else if (pos.state.h==90)
    {
      pos.nextstate.h=180;
    } else if (pos.state.h==135)
    {
      pos.nextstate.h=225;
    } else if (pos.state.h==180)
    {
      pos.nextstate.h=270;
      turnright();
    } else if (pos.state.h==225)
    {
      pos.nextstate.h=315;
    } else if (pos.state.h==270)
    {
      pos.nextstate.h=45;
    } else if (pos.state.h==315)
    {
      pos.nextstate.h=0;
    }
  }
}
