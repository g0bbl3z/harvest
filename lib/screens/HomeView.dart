import 'package:flutter/material.dart';
import 'package:harvest/controllers/UserController.dart';
import 'package:harvest/models/harvest.dart';
import 'package:harvest/models/user.dart';
import 'package:harvest/myColors.dart';
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
      backgroundColor: white,
      appBar: AppBar(title: Text("Your Harvests"), backgroundColor: green,),
      body: Center(
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black38,
            );
          },
          itemCount: userController.user.harvests.length == 0
              ? 1
              : userController.user.harvests.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 100.0),
                child: RaisedButton(
                    child: Text("Create Harvest",
                        style: TextStyle(color: Colors.white)),
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
              child: Container(
                height: 80,
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      foregroundColor: Colors.black,
                      backgroundColor: randomColor(),
                      child: Text(userController.user.harvests[index].harvestID
                          .toString(), style: TextStyle(fontWeight: FontWeight.w500),),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(userController.user.harvests[index].name,
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Text("This harvest follows ${userController.user.harvests[index].numTrends} trend(s)" +
                              " and ${userController.user.harvests[index].numPlaylists} playlist(s)"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
