// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names, camel_case_types, prefer_const_constructors
// Required Libraries
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

/*
 * 
 *        Widgets and UI elements for App
 * 
 */

// Text Widgets

class customText extends StatefulWidget {
  String value;
  double size;
  Color color;
  double pad;
  customText({
    required this.value,
    this.size = 22,
    this.color = CupertinoColors.white,
    this.pad = 12,
    Key? key,
  }) : super(key: key);

  @override
  _customTextState createState() => _customTextState();
}

class _customTextState extends State<customText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.pad),
      child: Text(
        widget.value,
        style: GoogleFonts.josefinSans(
          fontSize: widget.size,
          color: widget.color,
        ),
      ),
    );
  }
}

// Background Images
List<String> backgroundImages = [
  "assets/images/img1.png",
  "assets/images/img2.png",
  "assets/images/img3.png",
  "assets/images/img4.png",
  "assets/images/img5.png",
];

class background extends StatelessWidget {
  int index;

  background({this.index = 0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(backgroundImages[index]),
        ),
      ),
    );
  }
}

// Custom App Icons
Widget CounterIcon({int size = 10}) => SizedBox(
      width: size * 10,
      height: size * 10,
      child: Image.asset("assets/icons/CounterLogo.png"),
    );
Widget TimerIcon({int size = 10}) => SizedBox(
      width: size * 10,
      height: size * 10,
      child: Image.asset("assets/icons/TimerLogo.png"),
    );

// PageChange

PageChange({required BuildContext ctx, required Widget action}) {
  log("___  Going to " + action.runtimeType.toString() + "  ___");
  Navigator.of(ctx).push(
    CupertinoPageRoute(
      builder: (ctx) => action,
    ),
  );
}

PageChangeForever({required BuildContext ctx, required Widget action}) {
  log("___  Going to " + action.runtimeType.toString() + "  ___");
  Navigator.of(ctx).pushReplacement(
    CupertinoPageRoute(
      builder: (ctx) => action,
    ),
  );
}

PageBack(BuildContext ctx) {
  log("___  Going back   ___");
  Navigator.of(ctx).pop();
}

// Space Maker

Widget HorizontalSpace(double space) => Padding(
      padding: EdgeInsets.symmetric(
        horizontal: space,
        vertical: 0,
      ),
    );

Widget VerticalSpace(double space) => Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: space,
      ),
    );

// Clickables
class AppCard extends StatefulWidget {
  Widget child;
  Color cardColor;
  Function action;
  AppCard({
    required this.child,
    this.cardColor = CupertinoColors.activeBlue,
    required this.action,
    Key? key,
  }) : super(key: key);

  @override
  _AppCardState createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  @override
  Widget build(BuildContext contesxt) {
    return GestureDetector(
      onTap: () => widget.action(),
      child: Container(
        width: 400,
        height: 200,
        decoration: BoxDecoration(
          color: widget.cardColor.withOpacity(0.6),
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

class CardButton extends StatefulWidget {
  Function action;
  Widget child;
  CardButton({
    required this.child,
    required this.action,
    Key? key,
  }) : super(key: key);

  @override
  _CardButtonState createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.action(),
      child: Container(
        child: widget.child,
        width: 160,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: CupertinoColors.activeBlue.withOpacity(0.6),
        ),
      ),
    );
  }
}

class AppButton extends StatefulWidget {
  String? placeholder;
  Function? action;
  AppButton({
    required this.placeholder,
    required this.action,
    Key? key,
  }) : super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.action!(),
      child: Container(
        child: Center(
          child: customText(
            value: widget.placeholder!,
            size: 20,
          ),
        ),
        width: 138,
        height: 60,
        decoration: BoxDecoration(
          color: CupertinoColors.systemBlue,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          //border: Border.all(),
        ),
      ),
    );
  }
}

class AppToggle extends StatefulWidget {
  Widget child;
  final Function(bool) action;
  bool toggle = false;
  AppToggle({required this.child, required this.action, Key? key})
      : super(key: key);
  @override
  _AppToggleState createState() => _AppToggleState();
}

class _AppToggleState extends State<AppToggle> {
  Color defaultColor = CupertinoColors.activeBlue.withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.toggle = widget.toggle ? false : true;
          defaultColor = widget.toggle
              ? CupertinoColors.activeGreen
              : CupertinoColors.activeBlue;
        });
        log("State : " + widget.toggle.toString());
        widget.action(widget.toggle);
      },
      child: Container(
        child: widget.child,
        width: 160,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: defaultColor,
        ),
      ),
    );
  }
}

class AppListTile extends StatefulWidget {
  Widget child;
  Function action;
  AppListTile({
    required this.child,
    required this.action,
    Key? key,
  }) : super(key: key);

  @override
  _AppListTileState createState() => _AppListTileState();
}

class _AppListTileState extends State<AppListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.action(),
      child: Container(
        width: 400,
        height: 150,
        decoration: BoxDecoration(
          color: CupertinoColors.activeBlue.withOpacity(0.85),
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(16),
        child: widget.child,
      ),
    );
  }
}

// Input Fields

class AppInput extends StatefulWidget {
  String? value;
  TextEditingController? controller;
  bool isBigText;
  AppInput({this.isBigText = false, Key? key}) : super(key: key) {
    controller = TextEditingController();
  }
  String get getText => controller!.text;
  bool get isEmpty => controller!.text.isEmpty;
  @override
  _AppInputState createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7),
      child: SizedBox(
        child: CupertinoTextField(
          controller: widget.controller,
          padding: EdgeInsets.all(8),
          keyboardType:
              widget.isBigText ? TextInputType.multiline : TextInputType.text,
          maxLines: widget.isBigText ? 12 : 1,
          style: TextStyle(
            color: CupertinoColors.black,
          ),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(),
          ),
        ),
        width: 360,
        height: widget.isBigText ? 320 : 40,
      ),
    );
  }
}

// Alert Message
showAlert({
  required BuildContext context,
  String title = "Notification",
  Widget? content,
}) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: customText(
        value: title,
        size: 16,
      ),
      content: content,
      actions: [
        CupertinoDialogAction(
          child: customText(
            value: "Ok",
            size: 20,
          ),
          onPressed: () => PageBack(context),
        ),
      ],
    ),
  );
}

// Check Message
checkMessage({
  required BuildContext context,
  required Function accept,
  required Function denied,
  String title = "Are You sure?",
  Widget? content,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        title: customText(value: title, size: 18),
        message: content!,
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => accept(),
            child: customText(
              value: "Ok",
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () => denied(),
            child: customText(
              value: "Cancel",
            ),
          ),
        ],
      );
    },
  );
}

// Divider
class AppDivider extends StatelessWidget {
  Color color;
  AppDivider({this.color = CupertinoColors.white, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 1,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
      ),
    );
  }
}
