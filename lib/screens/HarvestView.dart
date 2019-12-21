

import 'package:flutter/material.dart';
import 'package:harvest/models/harvest.dart';

class HarvestView extends StatelessWidget {
  final Harvest harvest;
  const HarvestView({Key key, this.harvest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(harvest.name),),
      body: Center(
        child: Column(children: <Widget>[
          //TODO: Implement HarvestController
          Text("TODO: Get associated User Name for each trend: " + harvest.numTrends.toString()),
          Text("TODO: Get associated Playlist Name for each playlist: " + harvest.numPlaylists.toString()),
          Text("TODO: Add button to open playlist in spotify: " + harvest.harvestID.toString()),
          Text("TODO: Probably need to add refresh capabilities"),
        ],)
      ),
    );
  }
}