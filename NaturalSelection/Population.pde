class Population {
  Dot[] dots;

  float fitnessSum;
  int gen = 1;

  int bestDot = 0;

  int minStep = 400;

  Population(int size) {
    dots = new Dot[size];
    for (int i = 0; i < size; i++) {
      dots[i] = new Dot();
    }
  }


  //-------------------------------------------------------------------------------------------------------
  //show all dots
  void show() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].show();
    }
    dots[0].show();
  }

  //------------------------------------------------------------------------
  //update all dots
  void update() {
    for (int i = 0; i< dots.length; i++) {
      if (dots[i].brain.step > minStep) {
        dots[i].dead = true;
      } else {
        dots[i].update();
      }
    }
  }

  //--------------------------------------------------------------------
  //calculate all the fitnesses
  void calculateFitness() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].calculateFitness();
    }
  }


  //-----------------------------------------------------------------------------------------------

  boolean allDotsDead() {
    for (int i = 0; i < dots.length; i++) {
      if (!dots[i].dead && !dots[i].reachedGoal) { //if there are still some dots alive, then they are not all dead, so it returns false
        return false;
      }
    }

    return true;
  }



  //----------------------------------------------------------------------------------------------

  void naturalSelection() {
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calculateFitnessSum();

    newDots[0] = dots[bestDot].gimmeBaby();
    newDots[0].isBest = true;
    for (int i = 1; i< newDots.length; i++) {
      //select parent based on fitness
      Dot parent = selectParent();

      //get baby from them
      newDots[i] = parent.gimmeBaby();
    }

    dots = newDots.clone();
    gen ++;
  }

  //----------------------------------------------------------------------------------------------

  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i = 0; i < dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
  }
  //---------------------------------------------------------------------------------------------------


  Dot selectParent() {
    float rand = random(fitnessSum); //select a random dot to be the parent based on fitness score

    float runningSum = 0;

    for (int i = 0; i< dots.length; i++) {
      runningSum+= dots[i].fitness;
      if (runningSum > rand) {
        return dots[i];
      }
    }

    //should never get to this point

    return null;
  }

  //--------------------------------------------------------------------------------

  void mutateDemBabies() { //adds a chance to mutate the baby
    for (int i = 1; i< dots.length; i++) {
      dots[i].brain.mutate();
    }
  }

  //-----------------------------------------------------------------------------------------------------

  void setBestDot() { //determine which dot performed the based, and directly copy and paste it into the next generation
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i< dots.length; i++) {
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }

    bestDot = maxIndex;

    if (dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
      println("step:", minStep);
    }
  }
}
