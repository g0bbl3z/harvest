import 'package:flutter/material.dart';
import 'package:harvest/controllers/UserController.dart';
import 'package:harvest/models/user.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {

  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text("This is the User's Name: ${userController.user.name}"),
            ),
            Container(
              child: Text("This is the User's Username: ${userController.user.username}"),
            ),
            Image.network("${userController.user.imageURL}"),
          ],
        ),
      ),
    );
  }
}
