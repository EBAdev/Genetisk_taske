JSONArray values;

//settings
int maxWeight = 5000; // max weight in grams

float weightDiffInfluence = 25; // value in percent

float valueInfluence = 75; // value in percent, these two best equal 100%

float mutateRate = 4; // value in percent, on how likely an item is to mutate

int numBags = 100;

int generationFrequency = 100; // give value in milliseconds

int timer;
int numGen = 0;


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
    
    image(bag,width/2-100,height/2+20,400,400);
    textAlign(CENTER);
    fill(255,0,0);
    pushMatrix();
    translate(0,0);
    rotate(radians(15));
    text("Taskens fitness: " + floor(champions.get(champions.size()-1).fitness*100)+"%",width/2-100,height/2+100);
    text("Taskens værdi: " + floor(champions.get(champions.size()-1).bagValue)+"kr.",width/2-100,height/2+50);
    text("Taskens vægt: " + floor(champions.get(champions.size()-1).bagWeight)+"g",width/2-100,height/2+75);
    text("Generation: " +numGen,width/2-100,height/2+125);
    popMatrix();
    textSize(20);
    fill(0);
    text("Ting i tasken", width-100,60);
    textSize(15);
    StringList stuff = champions.get(champions.size()-1).items;
    for (int i = 0; i < stuff.size(); i++){
      text(stuff.get(i),width-100,60+25*(i+1));
    }
    if (floor(champions.get(champions.size()-1).fitness*100) != 100){
    nextGen();
    numGen++; 
    } else {
      textSize(32);
      textAlign(CENTER);
      text("Bedste taske er nu fundet!", width/2-70,40);
      noLoop();
    }
  
    timer = millis()+generationFrequency;
  }
}
