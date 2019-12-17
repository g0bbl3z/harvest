import 'package:flutter/material.dart';
import 'package:harvest/models/user.dart';

class HomeView extends StatefulWidget {
  final User user;
  HomeView({Key key, this.user}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("This is the User's Name: ${widget.user.name}"),
        ),
      ),
    );
  }
}
