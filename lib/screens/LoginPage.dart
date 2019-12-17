import 'package:flutter/material.dart';
import 'package:harvest/models/user.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void login() async{
    //fake an api call to create a User
    //await the amount indicated before continuing
    User user = await getFakeUser();
    //TODO: Add a progress indicator
    //navigate to the home page with the returned user
    Navigator.of(context).pushReplacementNamed("/home", arguments: user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Harvest!"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(child:Text("Welcome to Harvest!")),
            Container(child:Text("Login to your Spotify Account!")),
            RaisedButton(onPressed: () => login(), child: Text("Login with Spotify"),)
          ],
        ),
      ),
    );
  }
}
