import 'package:flutter/material.dart';
import 'package:harvest/models/song.dart';

class Seed {
  SeedType type;
  List<Song> songs;
}


enum SeedType {
  Playlist,
  RecentSongs,
  TopSongs,
}