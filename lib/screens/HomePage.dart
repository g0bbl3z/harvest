import 'package:flutter/material.dart';
import 'package:harvest/models/user.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

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
