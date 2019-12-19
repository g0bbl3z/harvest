import 'package:http/http.dart' as http;
import 'package:harvest/models/harvest.dart';
import 'package:harvest/models/seed.dart';
import 'package:harvest/models/song.dart';
import 'package:harvest/models/user.dart';
import 'api.dart';

class HttpApi implements Api {

  static const source = '';
  var client = new http.Client();

  @override
  Future<User> getUser(int userID) async {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getFollowersFromUser(int userID) {
    // TODO: implement getFollowersFromUser
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getFollowingFromUser(int userID) {
    // TODO: implement getFollowingFromUser
    throw UnimplementedError();
  }

  @override
  Future<List<Harvest>> getHarvestsFromUser(int userID) {
    // TODO: implement getHarvestsFromUser
    throw UnimplementedError();
  }

  @override
  Future<List<Seed>> getSeedsFromHarvest(int harvestID) {
    // TODO: implement getSeedsFromHarvest
    throw UnimplementedError();
  }

  @override
  Future<List<Song>> getSongsFromHarvest(int harvestID) {
    // TODO: implement getSongsFromHarvest
    throw UnimplementedError();
  }

}