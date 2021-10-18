class Day {
  int id;
  int glassesOfWater;
  bool practice;

  Day.empty(int id) {
    this.id = id;
    glassesOfWater = 0;
    practice = false;
  }

  Day(int id, int water, bool practice) {
    this.id = id;
    this.glassesOfWater = water;
    this.practice = practice;
  }

  void increaseWaterCounter() {
    glassesOfWater++;
  }

  void decreaseWaterCounter() {
    if (glassesOfWater > 0) {
      glassesOfWater = glassesOfWater - 1;
    }
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "glasses_of_water": glassesOfWater, "practice": practice ? 1 : 0};
  }

  static int getIdFor(DateTime date) {
    return int.parse("${100 + date.day}${100 + date.month}${100 + date.year % 2000}");
  }
}
