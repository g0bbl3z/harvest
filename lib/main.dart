import 'package:flutter/material.dart';
import 'package:harvest/screens/HomePage.dart';
import 'package:harvest/screens/LoginPage.dart';

import 'models/user.dart';

void main() => runApp(HarvestApp());

class HarvestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harvest',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => LoginPage());
            break;
          case '/home':
            User user = settings.arguments;
            return MaterialPageRoute(
              builder: (context) => HomePage(user: user),
            );
            break;
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
    );
  }
}

