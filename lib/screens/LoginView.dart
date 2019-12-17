import 'package:flutter/material.dart';
import 'package:harvest/constants.dart';
import 'package:harvest/controllers/LoginController.dart';
import 'package:provider/provider.dart';

import '../locator.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginController>(
      create: (context) => locator<LoginController>(),
      child: Consumer<LoginController>(
        builder: (context, controller, child) => Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(child: Text("Login page")),
              controller.state == ViewState.Busy
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: RaisedButton(
                        child: Text("Login"),
                        onPressed: () => () async {
                          var loginSuccess = await controller.login();
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
