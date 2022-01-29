// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:app/model/habit.dart';
import 'package:app/screens/HabitInfo/habitinfo.dart';
import 'package:app/screens/View/viewHabitController.dart';
import 'package:app/screens/appWidgets.dart';
import 'package:flutter/cupertino.dart';

import 'dart:developer';

class ViewHabitPage extends StatefulWidget {
  const ViewHabitPage({Key? key}) : super(key: key);
  @override
  _ViewHabitPageState createState() => _ViewHabitPageState();
}

class _ViewHabitPageState extends State<ViewHabitPage> {
  List<HabitObject> list = [];
  ViewHabitController controller = ViewHabitController();

  @override
  void initState() {
    super.initState();
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
        future: controller.initHiveBox(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            list = controller.getHabitList;
            log("No of habit records : " + list.length.toString());
            return Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImages[2]),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpace(65),
                    customText(
                      value: "Your Habits",
                      size: 60,
                      color: CupertinoColors.black,
                    ),
                    VerticalSpace(21),
                    list.isEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              color:
                                  CupertinoColors.systemGrey.withOpacity(0.75),
                            ),
                            margin: EdgeInsets.all(18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                VerticalSpace(32),
                                Icon(
                                  CupertinoIcons.bin_xmark,
                                  color: CupertinoColors.white,
                                  size: 40,
                                ),
                                VerticalSpace(22),
                                Center(
                                  child: customText(
                                    value: "There's nothing here",
                                  ),
                                ),
                                VerticalSpace(32),
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              List<Widget> symbols = [];
                              HabitObject object = list[index];
                              if (object.isCountable) {
                                symbols.add(
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: CounterIcon(size: 5),
                                  ),
                                );
                              }
                              if (object.isTimable) {
                                symbols.add(
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: TimerIcon(size: 5),
                                  ),
                                );
                              }
                              symbols.add(HorizontalSpace(5));
                              return AppListTile(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    customText(
                                      value: object.activityName,
                                      size: 24,
                                    ),
                                    Row(
                                      children: symbols,
                                    ),
                                  ],
                                ),
                                action: () {
                                  var key = controller.getKey(object);
                                  log("{$key}");
                                  PageChange(
                                    ctx: context,
                                    action: HabitInfoPage(
                                      hkey: key,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: customText(
              value: "Loading...",
              color: CupertinoColors.black,
            ),
          );
        },
      ),
    );
  }
}
