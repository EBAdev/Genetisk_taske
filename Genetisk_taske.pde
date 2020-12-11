JSONArray values;

//settings
int maxWeight = 5000; // max weight in grams

float weightDiffInfluence = 0; // value in percent

float valueInfluence = 100; // value in percent, these two best equal 100%

float mutateRate = 1; // value in percent, on how likely an item is to mutate

int numBags = 500;

int generationFrequency = 1; // give value in milliseconds

// more items can be added in the data.JSON file

int timer;
int numGen = 0;
int counter = 0;


PImage bag;

void setup() {
  size(640, 480);
  textSize(15);

  values = loadJSONArray("data.json");
  bag = loadImage("taske.png");

  initializeWorld();
  FirstGen();
  timer = millis()+generationFrequency;
}
void draw() {

  int time = millis();
  if (time > timer) {
    background(255);
    println("making next gen");
    println("current champion: " +bestFitness+ ", " +bestValue + ", " + bestWeight);
    imageMode(CENTER);

    image(bag, width/2-100, height/2+20, 400, 400);
    textAlign(CENTER);
    fill(255, 0, 0);
    pushMatrix();
    translate(0, 0);
    rotate(radians(15));
    text("Taskens fitness: " + floor(champions.get(champions.size()-1).fitness*100)+"%", width/2-100, height/2+100);
    text("Taskens værdi: " + floor(champions.get(champions.size()-1).bagValue)+"kr.", width/2-100, height/2+50);
    text("Taskens vægt: " + floor(champions.get(champions.size()-1).bagWeight)+"g", width/2-100, height/2+75);
    text("Generation: " +numGen, width/2-100, height/2+125);
    popMatrix();
    textSize(20);
    fill(0);
    text("Ting i tasken", width-100, 60);
    textSize(15);
    StringList stuff = champions.get(champions.size()-1).items;
    for (int i = 0; i < stuff.size(); i++) {
      text(stuff.get(i), width-100, 60+25*(i+1));
    }

    if (floor(champions.get(champions.size()-1).fitness*100) != 100) {
      nextGen();
      numGen++;
    }

    if (numGen >= 15) {
      counter = 0;
      for (int i =1; i < 16; i++) {
        int prevFit = floor(champions.get(champions.size()-(i+1)).fitness*100);
        int fit = floor(champions.get(champions.size()-i).fitness*100);
        if (fit == prevFit) {
          counter++;
        }
      }
    }

    if (counter == 15) {
      textSize(32);
      textAlign(CENTER);
      text("Bedste taske er nu fundet!", width/2-70, 40);
      noLoop();
    }

    timer = millis()+generationFrequency;
  }
}
