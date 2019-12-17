/*
 * A "Song Harvest" is a playlist made up of designated "Seeds"
 */
class Harvest {
  int harvestID;
  String name;

  Harvest({this.harvestID, this.name});

  Harvest.fromMap(Map<String, dynamic> json) {
    this.name = json["name"];
    this.harvestID = json["harvestID"];
  }
}
