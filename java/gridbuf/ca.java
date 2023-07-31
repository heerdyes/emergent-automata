import javafx.scene.canvas.GraphicsContext;

public class ca extends grid
{
  char[][] ngrid;
  
  public ca(double x,double y,double w,double h,int nr,int nc,GraphicsContext gc,String gf)
  {
    super(x,y,w,h,nr,nc,gc,gf);
    ngrid=new char[rows][cols];
  }
  
  public void copydata()
  {
    for(int i=0;i<rows;i++)
    {
      for(int j=0;j<cols;j++)
      {
        cgrid[i][j]=ngrid[i][j];
      }
    }
  }
  
  boolean chkruld(char r,char u,char l,char d)
  {
    return r=='/' || r=='\\' || 
           u=='/' || u=='\\' ||
           l=='/' || l=='\\' ||
           d=='/' || d=='\\';
  }
  
  public char applyreflection(char r,char u,char l,char d,char lu,char ld,char ru,char rd)
  {
    char tmp='\0';
    if(r=='/')   { tmp=ru; }
    if(u=='/')   { tmp=ru; }
    if(l=='/')   { tmp=ld; }
    if(d=='/')   { tmp=ld; }
    if(r=='\\')  { tmp=rd; }
    if(u=='\\')  { tmp=lu; }
    if(l=='\\')  { tmp=lu; }
    if(d=='\\')  { tmp=rd; }
    return tmp;
  }
  
  public void nextgen()
  {
    for(int i=0;i<rows;i++)
    {
      for(int j=0;j<cols;j++)
      {
        char u=cgrid[i==0?rows-1:i-1][j];
        char l=cgrid[i][j==0?cols-1:j-1];
        char d=cgrid[i==rows-1?0:i+1][j];
        char r=cgrid[i][j==cols-1?0:j+1];
        char lu=cgrid[i==0?rows-1:i-1][j==0?cols-1:j-1];
        char ld=cgrid[i==rows-1?0:i+1][j==0?cols-1:j-1];
        char ru=cgrid[i==0?rows-1:i-1][j==cols-1?0:j+1];
        char rd=cgrid[i==rows-1?0:i+1][j==cols-1?0:j+1];
        char z=cgrid[i][j];
        // redirection and pathway rules
        if(lu=='v' && ru=='v')                 { ngrid[i][j]=u; }
        else if(l=='v' && r=='v' && u=='/')    { ngrid[i][j]=ru; }
        else if(l=='v' && r=='v' && u=='\\')   { ngrid[i][j]=lu; }
        else if(ld=='^' && rd=='^')            { ngrid[i][j]=d; }
        else if(l=='\\' && u=='>' && d=='>')   { ngrid[i][j]=lu; }
        else if(lu=='>' && ld=='>')            { ngrid[i][j]=l; }
        else if(l=='^' && r=='^' && d=='/')    { ngrid[i][j]=ld; }
        else if(l=='^' && r=='^' && d=='\\')   { ngrid[i][j]=rd; }
        else if(u=='<' && d=='<' && r=='\\')   { ngrid[i][j]=rd; }
        else if(u=='<' && d=='<' && r=='/')    { ngrid[i][j]=ru; }
        else if(ru=='<' && rd=='<')            { ngrid[i][j]=r; }
        // transformation: +,-,*,%
        else if(lu=='-' && ru=='-')            { ngrid[i][j]=(char)((int)u-1); }
        else if(lu=='+' && ru=='+')            { ngrid[i][j]=(char)((int)u+1); }
        else if(r=='T')                        { ngrid[i][j]=(char)((int)ru/2); }
        else if(l=='T')                        { ngrid[i][j]=(char)((int)lu/2); }
        else if(r=='S')                        { ngrid[i][j]=ru; }
        else if(l=='S')                        { ngrid[i][j]=lu; }
        else if(u=='J')                        { ngrid[i][j]=(char)((int)lu+(int)ru); }
        else if(u=='M')                        { ngrid[i][j]=(char)(((int)lu+(int)ru)/2); }
        else if(r=='?' && ru==rd)              { ngrid[i][j]=ru; }
        else if(l=='?' && lu!=ld)              { ngrid[i][j]=lu; }
        else                                   { ngrid[i][j]=z; }
      }
    }
    copydata();
    rndr();
  }
  
  public void handlefnkey(String fk)
  {
    if(fk.equals("F5"))      { nextgen(); }
    else if(fk.equals("F2")) { u.savegrid(file,this); }
    else if(fk.equals("F3")) { u.loadgrid(file,this); }
  }
}

