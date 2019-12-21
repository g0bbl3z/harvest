import 'harvest.dart';

class User {
  String name;
  String username;
  int userID;
  String imageURL;
  List<Harvest> harvests = List();
  List<User> following = List();

  User({this.name, this.username, this.imageURL});

  User.fromMap(Map<String, dynamic> json) {
    this.userID = json["id"];
    this.name = json["name"];
    this.username = json["username"];
    this.imageURL = json["imageURL"];
  }

  setHarvests(List<Harvest> list) {
    this.harvests = list;
  }

  setFollowing(List<User> users) {
    this.following = users;
  }
}