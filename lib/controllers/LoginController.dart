import 'package:flutter/foundation.dart';
import 'package:harvest/api/api.dart';
import 'package:harvest/api/fake_api.dart';
import 'package:harvest/api/http_api.dart';
import 'package:harvest/locator.dart';
import 'package:harvest/models/loginResponse.dart';

/// Represents the state of the view
enum ViewState { Idle, Busy }

class LoginController extends ChangeNotifier {

  //locate the api service depending on Fake or Actual implementation
  final Api _apiService = USE_FAKE_IMPLEMENTATION ? locator<FakeApi>() : locator<HttpApi>();

  //create private state variable to track the status of the login
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  //change the state and notify consumers that the provider changed
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }


  //I am guessing at how the spotify login will be implemented
  Future<bool> login() async {
    //set the state of the login to Busy
    setState(ViewState.Busy);

    //Do the spotify login authentication and get the associated userID
    //We might not get the ID until we call _apiService.login() with a parameter of the spotify username
    int userID = 1;
    //call the api login method
    LoginResponse response = await _apiService.login(userID);
    //once it finishes, set the login to Idle
    setState(ViewState.Idle);
    //return the boolean
    return response.success;
  }


}