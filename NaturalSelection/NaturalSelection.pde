Population test;
PVector goal = new PVector(400, 10); //create a new PVector for the goal


void setup() {
  size(800, 800); //create a window
  test = new Population(5000); //make a new population with a specified number of dots (try changing this to see how the population acts)
}


void draw() {
  //color in the background
  background(255);

  //create the goal
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);

  //three main obstacles
  fill(0, 0, 255);
  rect(100, 350, 600, 10);
  rect(0, 450, 100, 10);
  rect(700, 450, 100, 10);

  //final box around the goal
  fill(0, 255, 0);
  rect(365, 0, 10, 50);
  rect(425, 0, 10, 50);
  rect(365, 50, 20, 10);
  rect(415, 50, 20, 10);


  if (test.allDotsDead()) { //if all the dots are dead, run the genetic algorithm
    //genetic algorithm
    test.calculateFitness();
    test.naturalSelection();
    test.mutateDemBabies();
  } else { //if they aren't all dead, keep updating and showing the dots


    test.update();
    test.show();
  }
}
