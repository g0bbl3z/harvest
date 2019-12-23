

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:harvest/models/harvest.dart';
import 'package:harvest/models/seed.dart';
import 'package:harvest/models/song.dart';
import 'package:harvest/models/user.dart';
import 'api.dart';

class FakeApi implements Api {

  static const source = 'https://my-json-server.typicode.com/g0bbl3z/harvest';
  var client = new http.Client();

  @override
  Future<User> getUser(int userID) async {
    var response = await client.get('$source/users/$userID');
    return User.fromMap(json.decode(response.body));
  }

  @override
  Future<List<User>> getFollowersFromUser(int userID) {
    // TODO: implement getFollowersFromUser
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getFollowingFromUser(int userID) async{
    List<User> ret = List();
    var following = await client.get('$source/userfollowers?userID=$userID');
    var followingJsn = json.decode(following.body);
    for(var following_entry in followingJsn) {
      ret.add(await getUser(following_entry["followsID"]));
    }
    return ret;
  }

  Future<bool> postUserHarvests(int userID, String harvestName, List<int> trends, List<String> playlists) async {
    await Future.delayed(Duration(seconds: 1));
    var headers ={
        HttpHeaders.contentTypeHeader: 'application/json'
      };
    String jsn = '{"name": "$harvestName", "userID": $userID}'; // make POST request
    var response = await client.post('$source/harvests', headers: headers, body: jsn); // check the status code for the result
    int harvestStatus = response.statusCode;
    print(harvestStatus);
    String body = response.body;
    int harvestID = json.decode(response.body)["id"];
    print(body);
    for(int id in trends) {
      jsn = '{"harvestID": "$harvestID", "endpoint": $id}'; // make POST request
      response = await client.post('$source/harvestseeds', headers: headers, body: jsn); // check the status code for the result
      int harvestSeedStatus = response.statusCode; // API passes back the id of the new item added to the body
      print(harvestSeedStatus.toString());
      body = response.body;
      print(body);
    }
    return true;
  }

  @override
  Future<List<Harvest>> getHarvestsFromUser(int userID) async {
    List<Harvest> ret = List();
    var response = await client.get('$source/harvests?userID=$userID');
    var jsn = json.decode(response.body);
    for(var item in jsn) {
      ret.add(Harvest.fromMap(item));
    }
    return ret;
  }

  @override
  Future<List<Seed>> getSeedsFromHarvest(int harvestID) async {
    List<Seed> ret = List();
    var response = await client.get('$source/harvestseeds?harvestID=$harvestID');
    var jsn = json.decode(response.body);
    for(var item in jsn) {
      ret.add(Seed.fromMap(item));
    }
    return ret;
  }

  @override
  Future<List<Song>> getSongsFromHarvest(int harvestID) {
    // TODO: implement getSongsFromHarvest
    throw UnimplementedError();
  }

}