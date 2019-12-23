/*
 * A "Song Harvest" is a playlist made up of designated "Seeds"
 */
class Harvest {
  int harvestID;
  String name;
  int numTrends = 0;
  int numPlaylists = 0;

  Harvest({this.harvestID, this.name});

  Harvest.fromMap(Map<String, dynamic> json) {
    this.name = json["name"];
    this.harvestID = json["id"];
  }

  setNumTrends(int numTrends) {
    this.numTrends = numTrends;
  }

  setNumPlaylists(int numPlaylists) {
    this.numPlaylists = numPlaylists;
  }

}
