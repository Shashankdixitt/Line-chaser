
## Demo

Click the link for demo 👉 
**[Video](https://youtu.be/Dy73jAYpFOE)**

**#Mouse Line Chaser**

A low level description of Game 🧑‍💻

**Classes:**           
Color: Represents an RGB color with three integer fields for red, green, and blue components.

**Point:**              
Represents a point in 2D space with integer coordinates x and y. It also includes a method Distance to calculate the distance between two points.

**LineSegment:**      
Represents a line segment defined by two points (a and b). It calculates its length (l) upon instantiation and includes methods to check if a point is on the line (GetOnLine) and to draw the line segment.

**Functions:**        
overlap_points: Checks if two points are closer than a given distance r.

**Setup:**                
Initializes the sketch by setting the canvas size, creating instances of Point for line segment endpoints defined in an array, and populating an ArrayList with LineSegment objects. Also, it sets up variables for tracking player progress and initializes the frame rate.

**Draw:**
The main drawing function called repeatedly by Processing. It handles drawing line segments, checking for player interactions (mouse movement and clicks), tracking player progress, displaying scores, and managing game levels and alerts.

**ShowScore:**      
Displays the player's score on the canvas.

**setAlert:**      
Sets an alert message and starts a timer to display it for a short duration.

**AlertTimer:** 
Runs on a separate thread to control the duration of alert messages.

**showAlert:**        
Displays the alert message on the canvas.

**checkDelay:**         
Checks for delays in player movement and updates a counter accordingly.

**Variables:**        
allSegments: ArrayList to store all line segments in the game.

lastCheckPoint:       
Tracks the last point the player interacted with.

**tracking:**    
Boolean flag to indicate whether the player's mouse is currently on a line segment.

**level:**          
Tracks the current level of the game --> balcka and white side.

**checkCounter:**           
Counts the number of line segments passed by the player.

**delayCounter:**      
Counts delays in player movement.

offCounter:        
Counts instances where the player moves off the line segments.

**gameFinished:**       
Indicates whether the game has been completed.

**Game Logic:**
  
*The player's objective is to move their mouse cursor along specific line segments without moving off or delaying too long.*

*The game consists of two levels, with different line segments drawn in different colors.*

*The player's score is calculated based on the number of line segments passed successfully.*

*Alerts are displayed for level changes and game completion.*

*Delays and off-line movements are penalized.*

*Overall, this code represents a simple interactive game where the player must navigate their mouse cursor along predefined paths to progress through levels and achieve a high score.*

**# Run Locally**

Clone the project

```bash
  git clone https://github.com/Shashankdixitt/Line-chaser
```

Go to the project directory

```bash
  cd Line-chaser
```

Install dependencies
```bash
 https://processing.org/download
```
🚀🚀 Install Processing and You are good to Go 🚀🚀



