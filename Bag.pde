class bag {
  int bagWeight = 0;
  int bagValue = 0;
  
  int maxWeight;
  float weightDiffInfluence;
  float valueInfluence;

  bag(int mW, float wDI, float vI) {
    maxWeight = mW; // max weight in grams
    weightDiffInfluence = wDI; //give in percent
    valueInfluence = vI; //give in percent, these two best equal 100%
  }

  StringList items = new StringList();
  IntList currentItems = new IntList();

  float fitness;


  void getRandomContent() {

    for (int i = 0; i < values.size(); i++) {
      int isInBag = floor(random(0, 2));
      if (isInBag == 1) {
        currentItems.append(1);
      } else {
        currentItems.append(0);
      }
    }
  }



  void getBagContent() {
    items.clear();
    bagWeight = 0;
    bagValue = 0;
    for (int i = 0; i < currentItems.size(); i++) {
      int inBag = currentItems.get(i);
      if (inBag == 1) {
        JSONObject item = values.getJSONObject(i); 
        String name = item.getString("Navn");
        int weight = item.getInt("Vaegt");
        int value = item.getInt("Kroner");
        bagWeight += weight;
        bagValue += value;
        items.append(name);
      }
    }
  }

  boolean tooHeavy() {
    if (bagWeight > maxWeight) {
      return true;
    } else {
      return false;
    }
  }

  void calcFitness() {
    if (tooHeavy()) {
      fitness = 0;
    } else {
      int weightDiff = maxWeight - bagWeight;

      float weightDiffMap = map(weightDiff, 0, 5000, weightDiffInfluence/100, 0);
      float valueMap = map(bagValue, 0, 1127, 0, valueInfluence/100);

      fitness = weightDiffMap + valueMap;
      fitness = fitness*fitness*fitness;
    }
  }
}
