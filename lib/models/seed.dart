class Seed {
  SeedType type;
  String name;

  Seed({this.type, this.name});

  //we may consider changing how this is stored in the API/database
  Seed.fromMap(Map<String, dynamic> json) {
    try {
      int userID = int.parse(json["endpoint"]);
      this.name = "GetUserTrendFromID: " + userID.toString();
      this.type = SeedType.Trend;
    } catch (e) {
      try { 
        String endpoint = json["endpoint"];
        this.name = "SpotifyPlaylistEndpoint: " + endpoint;
        this.type = SeedType.Playlist;
      } catch (error) {
        this.name = "Error";
      }
    }
  }
}

enum SeedType {
  Playlist,
  Trend,
}