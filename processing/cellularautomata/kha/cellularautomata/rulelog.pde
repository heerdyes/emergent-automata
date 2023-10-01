// angular pattern
//if (c.l.state==1 && c.r.state==1) c.nextstate=0;
//if (c.d.state==0 && c.state==0) c.nextstate=1;

// straightish grid
//int n1s=c.l.u.state+c.u.state+c.r.u.state+c.l.state+c.r.state+c.l.d.state+c.d.state+c.r.d.state;
//if (n1s<2 && c.state==0)c.nextstate=1;
//else if (n1s>5 && c.state==1)c.nextstate=0;

// 2 parts
//case "air":
//  c.nextstate.h=(c.l.state.h+c.r.state.h)%360;
//  c.nextstate.s=(c.r.state.s+c.d.state.s)%100;
//  break;
//case "water":
//  c.nextstate.b=round(0.98*c.u.state.b);
//  c.nextstate.s=(c.l.state.s+c.d.state.s)%100;
//  break;
