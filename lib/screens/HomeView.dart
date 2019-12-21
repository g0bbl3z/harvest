import 'package:flutter/material.dart';
import 'package:harvest/controllers/UserController.dart';
import 'package:harvest/models/harvest.dart';
import 'package:harvest/models/user.dart';
import 'package:harvest/screens/CreateHarvestView.dart';
import 'package:harvest/screens/HarvestView.dart';
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
      appBar: AppBar(title: Text("Your Harvests")),
      body: Center(
        child: ListView.builder(
          itemCount: userController.user.harvests.length == 0
              ? 1
              : userController.user.harvests.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 100.0),
                child: RaisedButton(
                    child: Text("Create Harvest"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return CreateHarvestView();
                        }),
                      );
                    }),
              );
            }
            index -= 1;
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return HarvestView(
                        harvest: userController.user.harvests[index]);
                  }),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                elevation: 2.0,
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(userController.user.harvests[index].name,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("This harvest follows ${userController.user.harvests[index].numTrends} trend(s)" +
                          " and ${userController.user.harvests[index].numPlaylists} playlist(s)"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
