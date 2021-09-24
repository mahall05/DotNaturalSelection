class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;

  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;

  float fitness = 0;

  long start;
  long finish;
  long elapsedTime;


  Dot() {
    brain = new Brain(400);

    //set a position, velocity, and acceleration for the dot
    pos = new PVector(width/2, height-10);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    start = System.currentTimeMillis();
  }


  //--------------------------------------------------------------------------------------------

  void show() { //display the dot on screen
    if (isBest) { //if the dot was the best dot in the last generation, it will be colored green
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    } else { //if it wasn't the best dot, it is colored black
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  //--------------------------------------------------------------------------------------------

  void move() { //tells the dot how to move

    if (brain.directions.length > brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else {
      dead = true;
    }
    vel.add(acc);
    vel.limit(7);
    pos.add(vel);
  }

  //--------------------------------------------------------------------------------------------

  void update() { //updates the dot's position and state
    if (!dead && !reachedGoal) {
      move(); //if it's not dead, allow the dot to move
      if (pos.x < 2 || pos.y < 2 || pos.x > width-2 || pos.y > height-2) { //if the dot touches the edge of the window, it dies
        dead = true;
      } else if (dist(pos.x, pos.y, goal.x, goal.y) < 5) {
        //if reached goal
        reachedGoal = true;
        finish = System.currentTimeMillis();
        elapsedTime = finish - start;
      } else if (pos.x < 700 && pos.y < 360 && pos.x > 100 && pos.y > 350) { //for the next 4 if statements, if the dot hits any of the obstacles, the dot dies
        dead = true;
      } else if ((pos.x < 100 && pos.y < 460 && pos.x > 0 && pos.y > 450) || (pos.x < 800 && pos.y < 460 && pos.x > 700 && pos.y > 450)) {
        dead = true;
      } else if ((pos.x > 365 && pos.y > 0 && pos.x < 375 && pos.y < 50) || (pos.x > 365 && pos.y > 50 && pos.x < 385 && pos.y < 60)) {
        dead = true;
      } else if ((pos.x > 425 && pos.y > 0 && pos.x < 435 && pos.y < 50) || (pos.x > 415 && pos.y > 50 && pos.x < 425 && pos.y < 60)) {
        dead = true;
      }
    }
  }


  //------------------------------------------------------------------------------

  void calculateFitness() { //calculate the fitness of the dot based on its performance
    if (reachedGoal) {
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step); //if it touches the goal, gives the dot a big boost in fitness based on how many steps it took to get to the goal
    } else {
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y); //if it didn't touch the goal, calculate fitness based on its distance from the goal
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
  }

  //-------------------------------------------------------------------------------------
  //clone it
  Dot gimmeBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  }
}
