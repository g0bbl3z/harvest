
import 'dart:math';

import 'package:flutter/material.dart';

const Color white = Color(0xFFE1E1E1);
const Color red = Color(0xFFB52B59);
const Color orange = Color(0xFFF77839);
const Color yellow = Color(0xFFFBCF38);
const Color teal = Color(0xFF24B4AF);
const Color pink = Color(0xFFFFAFCC);
const Color green = Color(0xFF39766A);

List<Color> lightColors = [orange, yellow, teal, pink];

Color randomColor() {
  var rng = Random();
  return lightColors[rng.nextInt(lightColors.length)];
}

//TODO: What's the significance of the value of RGB?
Map<int, Color> myColor = {
50: Color.fromRGBO(255, 92, 87, .1),
100: Color.fromRGBO(255, 92, 87, .2),
200: Color.fromRGBO(255, 92, 87, .3),
300: Color.fromRGBO(255, 92, 87, .4),
400: Color.fromRGBO(255, 92, 87, .5),
500: Color.fromRGBO(255, 92, 87, .6),
600: Color.fromRGBO(255, 92, 87, .7),
700: Color.fromRGBO(255, 92, 87, .8),
800: Color.fromRGBO(255, 92, 87, .9),
900: Color.fromRGBO(255, 92, 87, 1),
};