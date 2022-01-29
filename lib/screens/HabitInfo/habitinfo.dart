// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:app/model/habit.dart';
import 'package:app/screens/Action/actionPage.dart';
import 'package:app/screens/HabitInfo/habitInfoController.dart';
import 'package:app/screens/appWidgets.dart';
import 'package:flutter/cupertino.dart';

class HabitInfoPage extends StatefulWidget {
  String hkey;
  HabitInfoPage({
    required this.hkey,
    Key? key,
  }) : super(key: key);

  @override
  _HabitInfoPageState createState() => _HabitInfoPageState();
}

class _HabitInfoPageState extends State<HabitInfoPage> {
  List<Widget> statusRow = [];
  bool timePlacing = false;
  bool countPlacing = false;
  HabitObject? object;
  HabitInfoController controller = HabitInfoController();

  @override
  void initState() {
    super.initState();
    setState(() {
      log("Renders stuff...");
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: FutureBuilder(
        future: controller.initHiveBox(widget.hkey),
        builder: (context, snap) {
          if (snap.hasData) {
            object = controller.getObject;
            if (object!.isCountable && !countPlacing) {
              statusRow.add(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customText(
                      value: object!.actionCount.toString(),
                      size: 20,
                    ),
                    customText(value: "Times done", size: 21),
                  ],
                ),
              );
              countPlacing = true;
            }
            if (object!.isTimable && !timePlacing) {
              statusRow.add(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customText(
                      value: object!.timeTaken.toString(),
                      size: 20,
                    ),
                    customText(value: "Time Taken", size: 21),
                  ],
                ),
              );
              timePlacing = true;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                VerticalSpace(28),
                Padding(
                  padding: const EdgeInsets.all(23),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customText(
                        value: object!.activityName,
                        size: 32,
                        color: CupertinoColors.black,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23, vertical: 0),
                  child: Row(
                    children: [
                      Flexible(
                        child: customText(
                          value: object!.activityDescription,
                          size: 18,
                          color: CupertinoColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalSpace(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 400,
                      height: 200,
                      margin: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        color: CupertinoColors.activeBlue.withOpacity(0.6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: statusRow,
                      ),
                    ),
                    VerticalSpace(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CardButton(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.play_circle,
                                  color: CupertinoColors.white,
                                  size: 38,
                                ),
                                VerticalSpace(5),
                                customText(value: "Do it", size: 18),
                              ],
                            ),
                          ),
                          action: () {
                            PageChange(
                              ctx: context,
                              action: ActionPage(hkey: widget.hkey),
                            );
                          },
                        ),
                        HorizontalSpace(10),
                        CardButton(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.delete,
                                  color: CupertinoColors.white,
                                  size: 38,
                                ),
                                VerticalSpace(5),
                                customText(value: "Delete Activity", size: 18),
                              ],
                            ),
                          ),
                          action: () {
                            checkMessage(
                              title: "Delete Habit",
                              context: context,
                              content: Center(
                                child: customText(
                                    value:
                                        "Are your sure about the deletion\nOnce you delete the habit all saved progress will be lost"),
                              ),
                              accept: () {
                                controller.deleteObject(widget.hkey);
                                PageBack(context);
                                PageBack(context);
                                PageBack(context);
                              },
                              denied: () => PageBack(context),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                )
              ],
            );
          }
          return Center(
            child: customText(
              value: "Loading Habit...",
              color: CupertinoColors.black,
            ),
          );
        },
      ),
    );
  }
}
