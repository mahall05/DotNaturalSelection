Population test;
PVector goal = new PVector(400, 10);

Population population;


void setup() {
  size(800, 800);
  test = new Population(5000);
}


void draw() {
  background(255);
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);

  //three main obstacles
  fill(0,0,255);
  rect(100,350,600,10);
  rect(0,450,100,10);
  rect(700,450,100,10);
  
  //final box
  fill(0,255,0);
  rect(365,0,10,50);
  rect(425,0,10,50);
  rect(365,50,20,10);
  rect(415,50,20,10);


  if (test.allDotsDead()) {
    //genetic algorithm
    test.calculateFitness();
    test.naturalSelection();
    test.mutateDemBabies();
  } else {


    test.update();
    test.show();
  }
}
