// ignore_for_file: slash_for_doc_comments

import 'package:app/screens/Home/homePage.dart';
import 'package:app/screens/appWidgets.dart';
import 'package:flutter/cupertino.dart';

/*
 * 
 *   Splash Screen
 * 
 */

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () => PageChangeForever(
        ctx: context,
        action: const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          background(),
          Center(
            child: customText(
              value: "H A B I T",
              size: 70,
            ),
          ),
        ],
      ),
    );
  }
}
