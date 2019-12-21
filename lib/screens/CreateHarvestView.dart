import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:harvest/controllers/UserController.dart';
import 'package:harvest/models/seed.dart';
import 'package:harvest/models/user.dart';
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
        .map((entry) => Row(
              children: <Widget>[
                Checkbox(
                    value: entry.value,
                    onChanged: (val) {
                      setState(() {
                        selectedUsers.update(entry.key, (val) => !entry.value);
                      });
                    }),
                Text(entry.key.name)
              ],
            ))
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
      appBar: AppBar(title: Text(_harvestName)),
      body: ListView(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Harvest a new Playlist!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
            ),
          ),
          Stepper(
            currentStep: _currentStep,
            onStepContinue: () {
              setState(() {
                if (_currentStep < _maxSteps) {
                  _currentStep++;
                } else {
                  Navigator.pop(context);
                }
              });
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
                  title: Text("Enter Harvest Name"),
                  content: Column(
                    children: <Widget>[
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
                  title: Text("Select Trends"),
                  content: Column(
                    children: userCheckoffBoxes(),
                  )),
              Step(
                title: Text("Select Playlist"),
                content: Column(
                  children: <Widget>[
                    TextField(
                      decoration:
                          InputDecoration(hintText: "Search for a Playlist"),
                    ),
                  ],
                ),
              ),
              Step(
                  title: Text("Review Info"),
                  content: Column(
                    children: <Widget>[
                      Text("Name: " + _harvestName),
                      Text("Trends: " +
                          (Map.from(selectedUsers)
                                ..removeWhere((key, val) => !val))
                              .entries
                              .map((entry) => entry.key.name)
                              .toList()
                              .toString()),
                      Text("Playlists: "),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
