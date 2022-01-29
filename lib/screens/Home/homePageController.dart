// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:developer';
import 'package:app/screens/appWidgets.dart';
import 'package:flutter/cupertino.dart';

/*
 *    Controller for HomePage
 */

class HomePageController {
  HomePageController() {
    log("HomePageController Initalized");
  }
  Widget defaultPastActivity = Padding(
    padding: EdgeInsets.all(5),
    child: Column(
      children: [
        customText(
          value: "No Activity",
          size: 22,
        ),
      ],
    ),
  );
}
