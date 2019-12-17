import 'dart:collection';

import 'package:flutter/material.dart';

import 'harvest.dart';

import 'package:faker/faker.dart';

class User {
  String name;
  String username;
  int userID;
  String imageURL;
  List<Harvest> harvests;
  //API needs:
  //password
  //followers
  //playlists

  User({@required this.name, @required this.username, @required this.imageURL});

  User.fromMap(Map<dynamic, dynamic> json) {
    this.name = json["name"];
    this.username = json["username"];
    this.imageURL = json["imageURL"];
  }
}

//API calls go outside of User Class

Future getFakeUser() async {
  //simulate the await function
  await Future.delayed(const Duration(seconds: 1), () => "1");
  //build the json that would be returned from an api
  Map<String, String> map = new HashMap();
  map.putIfAbsent("name", () => faker.person.firstName());
  map.putIfAbsent("username", () => faker.internet.userName());
  map.putIfAbsent(
      "imageURL",
      () =>
          "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2800&q=80");
  return User.fromMap(map);
}

//TODO: Implement this method when the API can handle it
//then update the calling method to use this instead of
//getFakeData()
Future getUser() async {}
