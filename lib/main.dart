import 'package:flutter/material.dart';

import 'package:harvest/router.dart';
import 'package:harvest/screens/HomeView.dart';
import 'package:harvest/screens/LoginView.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
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
        onGenerateRoute: Router.generateRoute,
        initialRoute: RoutePaths.Login,
    );
  }
}
