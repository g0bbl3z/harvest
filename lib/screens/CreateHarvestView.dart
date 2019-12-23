import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:harvest/constants.dart';
import 'package:harvest/controllers/UserController.dart';
import 'package:harvest/models/seed.dart';
import 'package:harvest/models/user.dart';
import 'package:harvest/myColors.dart';
import 'package:provider/provider.dart';

class CreateHarvestView extends StatefulWidget {
  CreateHarvestView({Key key}) : super(key: key);

  @override
  _CreateHarvestViewState createState() => _CreateHarvestViewState();
}

class _CreateHarvestViewState extends State<CreateHarvestView> {
  String _harvestName = "Harvest";
  int _maxSteps = 3; // count begins at zero
  int _currentStep = 0;

  Map<User, bool> selectedUsers = Map();

  List<Widget> userCheckoffBoxes() {
    return selectedUsers.entries
        .map(
          (entry) => CheckoffToken(
            color: orange,
            title: entry.key.name,
            value: entry.value,
            onPress: () {
              setState(() {
                selectedUsers.update(entry.key, (val) => !entry.value);
              });
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    List<User> users = userController.user.following;
    selectedUsers.putIfAbsent(userController.user, () => false);
    for (User user in users) {
      selectedUsers.putIfAbsent(user, () => false);
    }
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(title: Text(_harvestName)),
      body: Theme(
        data: ThemeData(
          primaryColor: red,
          buttonColor: red,
        ),
        child: Stepper(
          type: StepperType.horizontal,
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: onStepContinue,
                  child: Text(
                    _currentStep == _maxSteps ? 'SUBMIT' : 'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                FlatButton(
                  onPressed: onStepCancel,
                  child: Text(_currentStep == 0 ? 'CANCEL' : 'Back'),
                ),
              ],
            );
          },
          currentStep: _currentStep,
          onStepTapped: (index) {
            setState(() {
              _currentStep = index;
            });
          },
          onStepContinue: () async {
            if (_currentStep < _maxSteps) {
              _currentStep++;
            } else {
              List<User> filteredUsers = (Map.from(selectedUsers)
                    ..removeWhere((key, val) => !val))
                  .entries
                  .map<User>((entry) => entry.key)
                  .toList();
              ;
              List<String> playlists = [];
              bool response = await userController.createUserHarvest(
                  _harvestName, filteredUsers, playlists);
              if (response) {
                Navigator.pop(context);
              } else {
                print("Error!");
              }
            }
            setState(() {});
          },
          onStepCancel: () {
            setState(() {
              if (_currentStep == 0) {
                Navigator.pop(context);
              } else {
                _currentStep--;
              }
            });
          },
          steps: [
            Step(
                isActive: _currentStep == 0,
                title: Text(_currentStep == 0 ? "Enter Harvest Name" : ""),
                content: Column(
                  children: <Widget>[
                    Container(
                        child: Text("Enter a Harvest Name",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500))),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          _harvestName = text;
                        });
                      },
                      decoration: InputDecoration(hintText: "Harvest Name"),
                    ),
                  ],
                )),
            Step(
                isActive: _currentStep == 1,
                title: Text(_currentStep == 1 ? "Select Trends" : ""),
                content: Column(
                  children: [
                    Container(
                        child: Text("Select User Trends to Sync With",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ...userCheckoffBoxes().sublist(
                                0, selectedUsers.entries.length ~/ 2 + 1),
                          ],
                        ),
                        VerticalDivider(
                          width: 30.0,
                        ),
                        Column(
                          children: <Widget>[
                            ...userCheckoffBoxes()
                                .sublist(selectedUsers.entries.length ~/ 2 + 1),
                          ],
                        )
                      ],
                    )
                  ],
                )),
            Step(
              //TODO: Implement actual playlist search
              isActive: _currentStep == 2,
              title: Text(_currentStep == 2 ? "Select Playlists" : ""),
              content: Column(
                children: <Widget>[
                  Container(
                      child: Text("Search for Playlists to Follow",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))),
                  TextField(
                    decoration:
                        InputDecoration(hintText: "Search for a Playlist"),
                  ),
                ],
              ),
            ),
            Step(
              isActive: _currentStep == 3,
              title: Text(_currentStep == 3 ? "Review Info" : ""),
              content: Column(
                children: <Widget>[
                  Container(
                      child: Text("Review the data",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))),
                  Text("Name: " + _harvestName),
                  Text("Trends: " +
                      (Map.from(selectedUsers)..removeWhere((key, val) => !val))
                          .entries
                          .map((entry) => entry.key.name)
                          .toList()
                          .toString()),
                  Text("Playlists: "),
                ],
              ),
            ),
          ],
        ),
      ),
      // ],
      // ),
    );
  }
}

class CheckoffToken extends StatefulWidget {
  Color color;
  String title;
  Function onPress;
  bool value;
  CheckoffToken({Key key, this.color, this.title, this.onPress, this.value})
      : super(key: key);

  @override
  _CheckoffTokenState createState() => _CheckoffTokenState();
}

class _CheckoffTokenState extends State<CheckoffToken> {
  toggle() {
    widget.onPress();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 150),
      child: widget.value
          ? RaisedButton(
              child: Text(widget.title, style: TextStyle(color: Colors.white)),
              color: widget.color,
              onPressed: () => setState(() {
                toggle();
              }),
            )
          : OutlineButton(
              borderSide: BorderSide(color: widget.color),
              textColor: widget.color,
              child: Text(widget.title),
              onPressed: () => setState(() {
                toggle();
              }),
            ),
    );
  }
}
