class Brain {
  PVector[] directions;
  int step = 0;


  Brain(int size) {
    directions = new PVector[size];
    randomize();
  }

  //--------------------------------------------------------------------

  void randomize() { //pick a random direction to move
    for (int i = 0; i< directions.length; i++) {
      float randomAngle = random(2*PI);
      directions[i] = PVector.fromAngle(randomAngle);
    }
  }

  //-------------------------------------------------------------------------

  Brain clone() { //creates a copy of the dot's brain for the next generation so it follows the same path as it's "parent"
    Brain clone = new Brain(directions.length);
    for (int i = 0; i< directions.length; i++) {
      clone.directions[i] = directions[i].copy();
    }

    return clone;
  }

  //-------------------------------------------------------------------------

  void mutate() { //a random chance for a mutation
    float mutationRate = 0.01; //the chance that the dot will mutate instead of being a proper clone (0.01 means a 1% chance)
    for (int i = 0; i< directions.length; i++) {
      float rand = random(1);
      if (rand < mutationRate) {
        //set this direction as a random direction
        float randomAngle = random(2*PI);
        directions[i] = PVector.fromAngle(randomAngle);
      }
    }
  }
}
