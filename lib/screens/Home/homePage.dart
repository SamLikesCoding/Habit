// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:app/screens/Add/addScreen.dart';
import 'package:app/screens/Home/homePageController.dart';
import 'package:app/screens/View/viewHabit.dart';
import 'package:app/screens/appWidgets.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageController controller = HomePageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Stack(
          children: [
            background(
              index: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpace(25),
                  customText(
                    value: "Hello",
                    size: 50,
                    color: CupertinoColors.black,
                  ),
                  VerticalSpace(15),
                  customText(
                    value: "Your Past Activity",
                    size: 28,
                    color: CupertinoColors.black,
                  ),
                  AppCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller.defaultPastActivity,
                      ],
                    ),
                    action: () {
                      log("appCard Invoked!");
                    },
                  ),
                  VerticalSpace(27),
                  customText(
                    value: "Actions",
                    size: 28,
                    color: CupertinoColors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CardButton(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.add_circled,
                                size: 44,
                                color: CupertinoColors.white,
                              ),
                              VerticalSpace(5),
                              customText(
                                value: "Add Habit",
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                        action: () {
                          log("Adding Habit");
                          PageChange(ctx: context, action: AddHabitPage());
                        },
                      ),
                      HorizontalSpace(5),
                      CardButton(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.list_bullet_below_rectangle,
                                size: 44,
                                color: CupertinoColors.white,
                              ),
                              VerticalSpace(5),
                              customText(
                                value: "View Habits",
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                        action: () {
                          PageChange(ctx: context, action: ViewHabitPage());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
