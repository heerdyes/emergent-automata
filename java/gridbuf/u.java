import java.io.IOException;
import java.io.PrintWriter;
import java.io.FileOutputStream;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.File;

public class u
{
  public static boolean cin(char c,String set)
  {
    for(int i=0;i<set.length();i++)
    {
      if(set.charAt(i)==c)
      {
        return true;
      }
    }
    return false;
  }
  
  public static boolean sin(String s,String[] arr)
  {
    for(int i=0;i<arr.length;i++)
    {
      if(s.equals(arr[i]))
      {
        return true;
      }
    }
    return false;
  }
  
  public static void d(String msg)
  {
    System.out.println("[DEBUG] "+msg);
  }
  
  public static void d(String[] msgs)
  {
    d("listing string array contents...");
    for(int i=0;i<msgs.length;i++)
    {
      d(String.format("[%02d] %s",i,msgs[i]));
    }
  }
  
  public static void a(String msg)
  {
    System.out.println("[ALERT] "+msg);
  }
  
  public static void e(Exception exc)
  {
    System.out.println("[EXCEPTION] "+exc.getMessage());
  }
  
  public static void savegrid(String fnm,grid g)
  {
    File fs=new File(fnm);
    try(FileOutputStream fos=new FileOutputStream(fs);
        PrintWriter pw=new PrintWriter(fos);)
    {
      for(int i=0;i<g.rows;i++)
      {
        for(int j=0;j<g.cols;j++)
        {
          pw.print(g.cgrid[i][j]);
        }
      }
      pw.flush();
      u.d("grid persisted to "+fnm);
    }
    catch (IOException ioe)
    {
      u.e(ioe);
    }
  }
  
  public static void loadgrid(String fnm,grid g)
  {
    File fs=new File(fnm);
    try(FileReader fr=new FileReader(fs);
        BufferedReader br=new BufferedReader(fr);)
    {
      for(int i=0;i<g.rows;i++)
      {
        for(int j=0;j<g.cols;j++)
        {
          g.cgrid[i][j]=(char)br.read();
        }
      }
      u.d("grid loaded from "+fnm);
    }
    catch (IOException ioe)
    {
      u.e(ioe);
    }
  }
  
}

