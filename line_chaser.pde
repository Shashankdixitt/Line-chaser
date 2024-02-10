class Color{
    public int r, g, b;
    public Color(int r, int g, int b)
    {
      this.r = r; this.g = g; this.b = b;
    }
  };
  class Point{
    public int x, y;
    public Point(int x, int y)
    {
      this.x = x;
      this.y = y;
    }
    //Gets distance from point
    public float Distance(Point a)
    {
      return (float) Math.sqrt( (x - a.x)*(x - a.x) + (y - a.y)*(y - a.y) );
    }
  };
  
  //For each line segment
  class LineSegment{
    public Point a, b;
    float l;
    public LineSegment(Point a, Point b)
    {
      this.a = a;
      this.b = b;
      l =(float) Math.sqrt( (b.x - a.x)*(b.x - a.x) + (b.y - a.y)*(b.y - a.y) );
    }
    
    //Checks if point is on the line with a tolerance
    public boolean GetOnLine(Point c, float r)
    {
      
      return a.Distance(c) + b.Distance(c) <= a.Distance(b) + r;
      
    }
    
    //Draws this segment
    public void Draw(Color col, int weight)
    {
      stroke(col.r, col.g, col.b);
      strokeWeight(weight);
      line(a.x, a.y, b.x, b.y);
    }
  };
  
  //Checks overlap between any two points;
  boolean overlap_points(Point a, Point b, float r)
  {
    float min_dist = r * 2;
    float d = a.Distance(b);
    
    if(d <= min_dist)
     return true;
    else
      return false;
  }
  
  
  //List of all segments
  ArrayList<LineSegment> allSegments= new ArrayList<LineSegment>();
  //The last checkPoint
  Point lastCheckPoint;
  
  
  void setup() {
    size(786, 601);
    noStroke();
    fill(255);
    
    int[] points = {
    80, height-10, 80, 470,
    80, 470,220,470,
    220, 470,220,400,
    220, 400,150,350, 
    150,350,220, 300, 
    220,300,220,250,
    220,250,170,200, 
    170,200,220,150, 
    220,150, 180,125, 
    180,125,220,100,  
    220,100,220,80, 
    220,80,150,80, 
    150,80,150,50, 
    150,50, 270,50, 
    270,50,270,25, 
    270,25,310,25, 
    310,25,310,75, 
    310,75,340,75, 
    340,75,340,50, 
    340,50,395,50, 
    395,50, 420,50,
    420,50,420,10, 
    420,10,450,25, 
    450,25,450,80, 
    450,80,500,80, 
    500,80,530,50, 
    530,50,600,50, 
    600,50,480,150,
    480,150,650,150,
    650,150,650,350,
    650,350,580,425,
    580,425,550,425,
    550,425,550,470,
    550,470,580,470,
    580,470,650,400,
    650,400,680,400,
    680,400,680,430,
    680,430,650,455,
    650,455,580,525,
    580,525,605,560,
    605,560,605,height-10
    };
    
    for(int i =0; i < points.length; i+= 4)
    {
      Point a = new Point(points[i], points[i+1]);
      Point b = new Point(points[i+2], points[i+3]);
      allSegments.add(new LineSegment(a, b));
    }
    
    lastCheckPoint = allSegments.get(0).a;
  
    tracking = true;
    
    frameRate(60);
  }
  
  //Tracking and scoring stuff
  boolean tracking = false;
  float trackingDist = 3.0f;
  int level = 0;
  int checkCounter = 0;
  int delayCounter = 0;
  int offCounter = 0;
  boolean offCounted = true;
  boolean delayCounted = true;
  boolean gameFinished = false;
  
  void draw() {
    stroke(255);
    background(0);
    if (X < 50) {
      rect(0, 0, 393, 786); // Left
    } else {
      rect(393, 0, 393, 786); // Right
    }
    
    
  
    if(gameFinished)
    {
      if(key == 'E' || key == 'e')
        exit();
    }
    
    
    Point mousePoint = new Point(mouseX, mouseY);
    Color black=  new Color(0, 0, 0);
    Color white = new Color(255, 255, 255);
    
    Color currentColor = new Color(0, 255, 0); //NOT USED
    
    boolean online = false;
    for(int i =0; i < allSegments.size()/ 2; i++)
    {
      LineSegment seg = allSegments.get(i);
      if( tracking && seg.GetOnLine(mousePoint, trackingDist) && level == 1)
      {
        seg.Draw(black, 9);
        lastCheckPoint = seg.a;
        online = true;
        
        checkCounter = max(checkCounter, i);
      }
      else
      {
        seg.Draw(black, 9);
        
      }
    }
    
    
    for(int i =allSegments.size()/ 2; i < allSegments.size(); i++)
    {
      LineSegment seg = allSegments.get(i);
      if( tracking && seg.GetOnLine(mousePoint, trackingDist) && level == 2)
      {
        seg.Draw(white, 9);
        lastCheckPoint = seg.a;
        online = true;
        
        checkCounter = max(checkCounter, i);// Score based on progress
      }
      else
      {
        seg.Draw(white, 9);
      }
    }
    if(!online) 
    {
      tracking = false;
      if(!offCounted)
      {
        offCounter++;
        offCounted = true;
        if(level != 0 && !gameFinished)
          setAlert("Game Over!");
      }
    }else
    {
      offCounted = false;
    }
    
    if(!delayCounted)
    {
      delayCounter++;
      delayCounted = true;
      lastFrame = frameCount;
    }
    
    
    
    stroke(255, 0, 0);
    //If the mouse is outside
    if(!tracking)
    {
      int r = 5;
      if(overlap_points(mousePoint, lastCheckPoint, trackingDist)) r = 10;
      else r = 5;
      ellipse(lastCheckPoint.x, lastCheckPoint.y, r, r);
      
    }
    else
    {
      stroke(255,255,0);
      ellipse(mouseX, mouseY, 20, 20);// Mouse is on the line
    }
    
    //Level 1 check
    if(overlap_points(mousePoint, allSegments.get(0).a, 3) && level == 0)
    {
      lastCheckPoint = allSegments.get(0).a;
      setAlert("Level 1");
      level++;
    }
    
    
    //Level 2 check
    if(tracking && overlap_points(mousePoint, allSegments.get(19).b, 3) && level == 1)
    {
      lastCheckPoint = allSegments.get( (allSegments.size()/ 2) ).a;
      setAlert("Level 2");
      level++;
    }
    
    //Game finish check
    if(tracking && overlap_points(mousePoint, allSegments.get(40).b, 3) && level == 2)
    {
      lastCheckPoint = allSegments.get( (allSegments.size()-1) ).b;
      setAlert("Game Win! E to exit!");
      level++;
      gameFinished = true;
    }
    
    //Shows if alert is pending
    if(alert)
    {
      showAlert();
    }
    
    showScore();
    
    checkDelay();
  }
  
  //Shows the score
  void showScore()
  {
    String scoreText = Integer.toString( (checkCounter -offCounter - delayCounter) * 5);
    textSize(36);
    fill(233, 50, 40);
    text(scoreText, 0, 0, 100, 60);  // Default depth, no z-value specified
    fill(255,255,255);
  }
  
  boolean alert = false;
  String currentText = "";
  //Starts the alert timer as well
  void setAlert(String t)
  {
    currentText = t;
    if(!alert)
      thread("alertTimer");
  }
  
  //Another thread timer
  void alertTimer()
  {
    alert = true;
    delay(2000);
    alert = false;
  }
  
  //For showing alert
  public void showAlert()
  {
    textSize(72);
    fill(233, 50, 40);
    text(currentText, width/2- 100, height/2, width/2 + 100, height/2 + 100);  // Default depth, no z-value specified
    fill(255,255,255);
  }
  
  int lastFrame = 0;
  int delaySeconds = 2;
  
  //For checking delay
  void checkDelay()
  {
    if(!tracking) return;
    float delta = max( mouseX-pmouseX, mouseY-pmouseY);
    int currFrame = frameCount;
    int diff = currFrame - lastFrame;
    if(diff >= frameRate * delaySeconds)
    {
      delayCounted = false;
    }
    
  }
  
  void mouseMoved()
  {
    lastFrame = frameCount;
  }
  
  
  void mouseClicked()
  {
    if(!tracking)
    {
      Point mousePoint = new Point(mouseX, mouseY);
      if(overlap_points(mousePoint, lastCheckPoint, trackingDist)) tracking = true;
    }
  }
