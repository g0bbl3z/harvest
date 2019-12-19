

import 'package:flutter/material.dart';
import 'package:harvest/api/api.dart';
import 'package:harvest/constants.dart';
import 'package:harvest/locator.dart';
import 'package:harvest/models/user.dart';

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
    var fetchedUser = await _api.getUser(1);
    var hasUser = fetchedUser != null;
    if (hasUser) {
      _user = fetchedUser;
    }
    setState(ViewState.Idle);
    return hasUser;
  }



}