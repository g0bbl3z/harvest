

import 'package:flutter/material.dart';
import 'package:harvest/api/api.dart';
import 'package:harvest/constants.dart';
import 'package:harvest/locator.dart';
import 'package:harvest/models/harvest.dart';
import 'package:harvest/models/seed.dart';
import 'package:harvest/models/user.dart';

const int FAKE_USER_ID = 1;

class UserController extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  User _user;

  User get user => _user;
  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Api _api = locator<Api>();

  //TODO: Login will look different when using spotify logins
  Future<bool> login () async {
    setState(ViewState.Busy);
    //For now, always get userID 1 -> Zeke
    var fetchedUser = await _api.getUser(FAKE_USER_ID);
    var hasUser = fetchedUser != null;
    if (hasUser) {
      _user = fetchedUser;
      var hasFollowing = await getFollowing();
      
    }
    setState(ViewState.Idle);
    return hasUser;
  }

  Future<bool> getUserHarvests() async {
    setState(ViewState.Busy);
    List<Harvest> fetchedHarvests = await _api.getHarvestsFromUser(_user.userID);
    for(Harvest harvest in fetchedHarvests) {
      List<Seed> seeds = await _api.getSeedsFromHarvest(harvest.harvestID);
      int numPlaylist = 0;
      int numTrends = 0;
      for(Seed seed in seeds) {
        seed.type == SeedType.Playlist ? numPlaylist++ : numTrends++;
      }
      harvest.setNumPlaylists(numPlaylist);
      harvest.setNumTrends(numTrends);
    }
    if (fetchedHarvests.length <= 0) {
      setState(ViewState.Idle);
      return false;
    } else {
      _user.setHarvests(fetchedHarvests);
      setState(ViewState.Idle);
      return true;
    }
  }

  Future<bool> getFollowing() async {
    setState(ViewState.Busy);
    List<User> fetchedUsers = await _api.getFollowingFromUser(_user.userID);
    if(fetchedUsers.length <= 0) {
      return false;
    }
    else {
      _user.setFollowing(fetchedUsers);
      return true;
    }
  }

  Future<bool> createUserHarvest(String harvestName, List<User> trends, List<String> playlists) async {
    setState(ViewState.Busy);
    List<int> trendIDs = trends.map((trend) => trend.userID).toList();
    bool response = await _api.postUserHarvests(_user.userID, harvestName, trendIDs, playlists);
    setState(ViewState.Idle);
    return response;
  }



}