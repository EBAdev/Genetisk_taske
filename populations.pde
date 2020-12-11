ArrayList<bag> bags = new ArrayList<bag>(); // array for this ge 
ArrayList<bag> bestBags = new ArrayList<bag>(); //array for viable to next gen
ArrayList<bag> nextGen = new ArrayList<bag>(); // array for next gen
ArrayList<bag> prevGen = new ArrayList<bag>(); // array for previous gen
ArrayList<bag> champions = new ArrayList<bag>(); // array containing the best from each gen

float bestFitness = 0;

int bestValue = 0;

int bestWeight = 0;


void initializeWorld() {
  for (int i = 0; i < numBags; i++) { 
    bags.add(new bag(maxWeight, weightDiffInfluence, valueInfluence));
  }
}

void FirstGen() {
  for (int j =0; j< bags.size(); j++) {

    bag b = bags.get(j);
    b.getRandomContent();    //compute the bags
    b.getBagContent();
    b.calcFitness();
    prevGen.add(b); // Log this bag as done
  }
  toNextGen(); // poolselection
  initializeNextGen(); // make next Gen

  int id = getGenrationsBestFit();
  champions.add(bags.get(id)); //Log the best one
}


void initializeNextGen() {
  nextGen.clear();
  for (int i = 0; i < numBags; i++) {
    int m = floor(random(0, bestBags.size()));
    int d = floor(random(0, bestBags.size()));
    bag mom = bestBags.get(m);
    bag dad = bestBags.get(d);

    nextGen.add(new bag(maxWeight, weightDiffInfluence, valueInfluence));  // add a child to the next gen
    bag child = nextGen.get(i);  

    mutate(mom, dad, child);       //mutate the child by the mom and dad
  }
}

void mutate(bag mom, bag dad, bag child) {
  // we set the childs values as an crossover by the moms and dads values

  for (int l =0; l < mom.currentItems.size(); l++) { // get moms items
    int r = roll();
    if ( r == 1 ) {             
      child.currentItems.set(l, dad.currentItems.get(l)); // set as dads value
    } else {
      child.currentItems.set(l, mom.currentItems.get(l));
    }

    float toBeMutated = random(0, 1);     //roll a dice
    if (toBeMutated < mutateRate/100) { //check if item should mutate
      if (child.currentItems.get(l) == 1) {
        child.currentItems.set(l, 0);
      } else {
        child.currentItems.set(l, 1);

      }
    }
  }
}
void nextGen() {

  bags.clear();
  bestBags.clear(); // remove the old gen

  for (int i =0; i< nextGen.size(); i++) {
    bag b = nextGen.get(i);                //Get the childs and make them the current gen
    bags.add(b);
  }

  for (int j =0; j< bags.size(); j++) {

    bag b = bags.get(j);
    b.getBagContent();
    b.calcFitness();
    prevGen.add(b); // Log this bag as done
  }

  toNextGen(); // poolselection
  initializeNextGen(); // make next Gen

  int id = getGenrationsBestFit();
  champions.add(bags.get(id)); //Log the best one
}


int getGenrationsBestFit() {
  float currentBest = 0;
  int currentBestId = 0;
  for (int k =0; k< bags.size(); k++) {
    bag b = bags.get(k);                   
    if (b.fitness >= currentBest) {
      currentBest = b.fitness;
      currentBestId = k;
      if (b.fitness >= bestFitness) {
        bestFitness = b.fitness;
        bestValue = b.bagValue;
        bestWeight = b.bagWeight;
      }
    }
  }
  return currentBestId;
}

void toNextGen() {
  for (int j =0; j< bags.size(); j++) {
    bag b = bags.get(j);
    int score = floor(b.fitness*10);
    for (int i = 0; i <= score; i++) {
      bestBags.add(b);
    }
  }
}


int roll() {
  int r = floor(random(0, 2));
  return r;
}
