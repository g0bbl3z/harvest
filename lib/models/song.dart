class Song {
  String name;
  String artist;
  String songURL;

  Song({this.name, this.artist, this.songURL});

  Song.fromMap(Map<String, dynamic> json) {
    this.name = json["name"];
    this.artist = json["artist"];
    this.songURL = json["songURL"];
  }
}