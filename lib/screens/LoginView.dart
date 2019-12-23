import 'package:flutter/material.dart';
import 'package:harvest/constants.dart';
import 'package:harvest/controllers/UserController.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, userController, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Login page"),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: userController.state == ViewState.Busy
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        child: Text("Login"),
                        onPressed: () async {
                          var loginSuccess = await userController.login();
                          await userController.getUserHarvests();
                          if (loginSuccess)
                            Navigator.pushNamed(context, RoutePaths.Home);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
