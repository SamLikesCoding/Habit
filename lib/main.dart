import 'dart:io';

import 'package:app/model/habit.dart';
import 'package:app/model/timeRecord.dart';
import 'package:app/screens/splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  Hive.registerAdapter(HabitObjectAdapter());
  Hive.registerAdapter(TimeRecordAdapter());
  runApp(const EntryPoint());
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        child: Center(
          child: SplashScreen(),
        ),
      ),
    );
  }
}
