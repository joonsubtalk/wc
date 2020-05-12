import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wc/screens/FinishScreen.dart';
import 'package:wc/screens/HomepageScreen.dart';
import 'screens/AddPrayerFlowScreen.dart';
import 'screens/PrayerScreen.dart';
import 'screens/LogScreen.dart';
import 'screens/SettingScreen.dart';
import './models/request.dart';
import './models/prayer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return ScopedModel<PrayerModel>(
      model: PrayerModel(),
      child: ScopedModel<RequestModel>(
        model: RequestModel(),
        child: MaterialApp(
          title: 'Provider Demo',
          initialRoute: '/',
          routes: {
            '/': (context) => HomepageScreen(),
            '/create': (context) => AddPrayerFlowScreen(),
            '/logs': (context) => LogScreen(),
            '/pray': (context) => PrayerScreen(),
            '/finish': (context) => FinishScreen(),
            '/settings': (context) => SettingScreen(),
          },
        ),
      ),
    );
  }
}
