class User {
  String name;
  String username;
  int userID;
  String imageURL;

  User({this.name, this.username, this.imageURL});

  User.fromMap(Map<dynamic, dynamic> json) {
    this.userID = json["id"];
    this.name = json["name"];
    this.username = json["username"];
    this.imageURL = json["imageURL"];
  }
}