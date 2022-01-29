// ignore_for_file: must_be_immutable, file_names, prefer_const_constructors

import 'dart:developer';

import 'package:app/model/habit.dart';
import 'package:app/screens/Action/actionPageController.dart';
import 'package:app/screens/appWidgets.dart';
import 'package:flutter/cupertino.dart';

class ActionPage extends StatefulWidget {
  String hkey;
  ActionPage({required this.hkey, Key? key}) : super(key: key);

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  ActionPageController? controller;
  Widget placeholder = Center(
    child: const CupertinoActivityIndicator(
      radius: 50,
    ),
  );
  HabitObject? object;
  @override
  void initState() {
    super.initState();
    controller = ActionPageController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: FutureBuilder(
          future: controller!.initHiveBox(widget.hkey),
          builder: (ctx, snp) {
            if (snp.hasData) {
              bool timePlacing = false;
              bool countPlacing = false;
              List<Widget> menu = [
                customText(
                  value: "Let's do it",
                  size: 40,
                ),
                VerticalSpace(20),
              ];
              object = controller!.referenceObject;
              if (object!.isTimable && !timePlacing) {
                menu.add(
                  CardButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TimerIcon(size: 6),
                        VerticalSpace(5),
                        customText(value: "Time"),
                      ],
                    ),
                    action: () {
                      PageChange(
                        ctx: context,
                        action: StopWatchPage(controller: controller!),
                      );
                    },
                  ),
                );
                menu.add(
                  VerticalSpace(10),
                );
                timePlacing = true;
              }
              // For Counter
              if (object!.isCountable && !countPlacing) {
                menu.add(
                  CardButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CounterIcon(size: 6),
                        VerticalSpace(5),
                        customText(value: "Count"),
                      ],
                    ),
                    action: () {
                      PageChange(
                        ctx: context,
                        action: CounterPage(controller: controller!),
                      );
                    },
                  ),
                );
                menu.add(
                  VerticalSpace(10),
                );
                countPlacing = true;
              }
              menu.add(
                AppButton(
                  placeholder: "Done",
                  action: () {
                    controller!.updateHabit();
                    PageBack(context);
                  },
                ),
              );
              return Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(backgroundImages[4]), fit: BoxFit.fill),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: menu,
                ),
              );
            }
            return placeholder;
          },
        ),
      ),
    );
  }
}

class StopWatchPage extends StatefulWidget {
  ActionPageController controller;
  StopWatchPage({required this.controller, Key? key}) : super(key: key);

  @override
  _StopWatchPageState createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(),
    );
  }
}

class CounterPage extends StatefulWidget {
  ActionPageController controller;
  CounterPage({required this.controller, Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    // Basic stuff
    TextEditingController controller = TextEditingController(text: "0");
    void endAction() {
      int value = int.parse(controller.text);
      log("Count = " + value.toString());
      widget.controller.updateCount(value);
      PageBack(context);
    }

    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customText(
              value: "Today's record",
              size: 35,
            ),
            VerticalSpace(30),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: CupertinoColors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: CupertinoTextField.borderless(
                  controller: controller,
                  onEditingComplete: () => endAction(),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 80,
                  ),
                ),
              ),
            ),
            VerticalSpace(45),
            AppButton(
              placeholder: "Done",
              action: () => endAction(),
            ),
          ],
        ),
      ),
    );
  }
}
