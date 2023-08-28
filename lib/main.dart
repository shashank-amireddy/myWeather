import 'package:flutter/material.dart';
import 'package:my_weather/Activity/home.dart';
import 'package:my_weather/Activity/loading.dart';
import 'package:my_weather/Activity/location.dart';


void main() {
  runApp(MaterialApp(
    routes: {
      "/": (context) => Loading(),
      "/home" : (context) => Home(),
      "/loading": (context) => Loading(),

    },
  ));
}

