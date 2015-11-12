SpaceShip aha;
boolean left,right,accelerate,reverse,hyperspace;
public void setup() 
{
  size(525,525);
  aha = new SpaceShip();
}
public void draw() 
{
  noStroke();
  background(0);
  aha.move();
  aha.show();
  System.out.println(aha.getDirectionX());
  //Smoother Movement
  if(left){aha.rotate(-5);}
  if(right){aha.rotate(5);}
  if(accelerate){aha.accelerate(0.1);}
  if(reverse)
  {
   if((float)(aha.getDirectionX())>0)
    {
      float x=(float)(aha.getDirectionX());
      x=x-0.1;
      aha.setDirectionX(x);
    }
   if((float)(aha.getDirectionX())<0)
    {
      float x=(float)(aha.getDirectionX());
      x=x+0.1;
      aha.setDirectionX(x);
    }


  }
}

public void keyPressed()
{
  if(key=='a'){left=true;}
  if(key=='d'){right=true;}
  if(key=='w'){accelerate=true;}
  if(key=='s'){reverse=true;}
}

public void keyReleased()
{
  if(key=='a'){left=false;}
  if(key=='d'){right=false;}
  if(key=='w'){accelerate=false;}
  if(key=='s'){reverse=false;}
}
class SpaceShip extends Floater  
{   
  public SpaceShip()
  
  {
    corners=4;
    xCorners = new int [corners];
    yCorners = new int [corners];
    xCorners[0] = -8;
    yCorners[0] = -8;
    xCorners[1] = 16;
    yCorners[1] = 0;
    xCorners[2] = -8;
    yCorners[2] = 8;
    xCorners[3] = -2;
    yCorners[3] = 0;
    myColor=255;
    myCenterX=250;
    myCenterY=250;
    myDirectionX=0;
    myDirectionY=0;
    myPointDirection=0;
  }
  
  public void setX(int x){myCenterX=x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY=y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX=x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY=y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection=degrees;}
  public double getPointDirection(){return myPointDirection;} 
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if (myCenterX >width+50)
    {     
      myCenterX = -50;
    } else if (myCenterX<-50)
    {     
      myCenterX = width+50;
    }    
    if (myCenterY >height+50)
    {    
      myCenterY = -50;
    } else if (myCenterY < -50)
    {     
      myCenterY = height+50;
    }
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for (int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated, yRotatedTranslated);
    }   
    endShape(CLOSE);
  }
} 

