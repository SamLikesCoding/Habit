// ignore_for_file: file_names, prefer_const_constructors_in_immutables, must_be_immutable

import 'dart:developer';
import 'package:app/screens/Add/addScreenController.dart';
import 'package:app/screens/appWidgets.dart';
import 'package:flutter/cupertino.dart';

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({Key? key}) : super(key: key);

  @override
  _AddHabitPageState createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  AddPageController? controller;

  @override
  void initState() {
    super.initState();
    controller = AddPageController();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      // ignore: prefer_const_constructors
      child: controller!.compSwitch!
          ? PageComponent1(
              action: (actName, actDescp) {
                controller!.initHabitObject(
                  activityName: actName,
                  activityDescription: actDescp,
                );
                setState(() {
                  controller!.compSwitch = false;
                });
              },
            )
          : PageComponent2(
              action: (isTimeable, isCountable) {
                controller!.setMeasureType(isTimeable, isCountable);
                controller!.addObject();
                PageBack(context);
              },
            ),
    );
  }
}

class PageComponent1 extends StatefulWidget {
  final Function(String, String) action;
  PageComponent1({required this.action, Key? key}) : super(key: key);

  @override
  _PageComponent1State createState() => _PageComponent1State();
}

class _PageComponent1State extends State<PageComponent1> {
  AppInput actName = AppInput();
  AppInput actDescp = AppInput(
    isBigText: true,
  );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 80,
          left: 20,
          child: customText(
            value: "Add new",
            size: 60,
            color: CupertinoColors.black,
          ),
        ),
        Positioned(
          top: 128,
          left: 18,
          child: customText(
            value: "Habit",
            size: 80,
            color: CupertinoColors.systemBlue,
          ),
        ),
        Positioned(
          top: 240,
          left: 18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                value: "Activity Name",
                size: 22,
                color: CupertinoColors.black,
              ),
              actName,
              VerticalSpace(5),
              customText(
                value: "Activity Description",
                size: 22,
                color: CupertinoColors.black,
              ),
              actDescp,
              VerticalSpace(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    placeholder: "Back",
                    action: () {
                      PageBack(context);
                    },
                  ),
                  HorizontalSpace(50),
                  AppButton(
                    placeholder: "Next",
                    action: () {
                      if (actName.isEmpty) {
                        showAlert(
                          context: context,
                          title: "Empty Activity Name",
                          content: customText(
                            value: "Looks like we got name for the activity",
                            size: 18,
                          ),
                        );
                      } else {
                        String activtyName = actName.getText;
                        String activtyDescp = actDescp.getText;
                        widget.action(activtyName, activtyDescp);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PageComponent2 extends StatefulWidget {
  final Function(bool, bool) action;
  bool countState = false;
  bool timeState = false;
  PageComponent2({required this.action, Key? key}) : super(key: key);

  @override
  _PageComponent2State createState() => _PageComponent2State();
}

class _PageComponent2State extends State<PageComponent2> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 90,
          left: 20,
          child: customText(
            value: "How to Monitor",
            size: 40,
            color: CupertinoColors.black,
          ),
        ),
        Positioned(
          top: 128,
          left: 18,
          child: customText(
            value: "Habits",
            size: 80,
            color: CupertinoColors.systemBlue,
          ),
        ),
        Positioned(
          top: 240,
          left: 18,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VerticalSpace(36),
              Row(
                children: [
                  AppToggle(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          VerticalSpace(5),
                          CounterIcon(),
                          customText(
                            value: "Counting",
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    action: (toggleState) {
                      widget.countState = toggleState;
                    },
                  ),
                  HorizontalSpace(7),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: customText(
                        value:
                            """Takes count of your habit\n\ne.g - how much push-ups\ntaken a day""",
                        size: 55,
                        color: CupertinoColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  AppToggle(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          VerticalSpace(5),
                          TimerIcon(),
                          customText(
                            value: "Timing",
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    action: (toggleState) {
                      widget.timeState = toggleState;
                    },
                  ),
                  HorizontalSpace(7),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: customText(
                        value:
                            """Takes how much time taken\nto work on habit\n\ne.g - time taken for\nrunning a path""",
                        size: 55,
                        color: CupertinoColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              VerticalSpace(22),
              AppButton(
                placeholder: "Create Habit",
                action: () {
                  if (!widget.countState && !widget.timeState) {
                    showAlert(
                      context: context,
                      title: "No Measure Variable",
                      content: customText(
                        value:
                            "We need either or one of these measures for recording habits\nPlease pick one or both",
                        size: 20,
                      ),
                    );
                  } else {
                    log("Countable :" +
                        widget.countState.toString().toUpperCase());
                    log("Timeable : " +
                        widget.timeState.toString().toUpperCase());
                    widget.action(widget.timeState, widget.countState);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
