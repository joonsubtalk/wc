import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wc/models/category.dart';
import 'package:wc/models/prayer.dart';
import 'package:wc/utils/database_helper.dart';
import 'package:wc/widgets/PrayerList.dart';

class HomepageScreen extends StatefulWidget {
  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  PrayerModel prayerModel;
  bool isReady = false;

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    prayerModel = ScopedModel.of<PrayerModel>(context, rebuildOnChange: true);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            colors: [
              Color(0xfffdfdfd),
              Color(0xfffdfdfd),
            ],
          ),
        ),
        child: SafeArea(
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pushNamed(context, '/create'),
                child: Text('New Prayer'),
              ),
              FlatButton(
                onPressed: () => Navigator.pushNamed(context, '/logs'),
                child: Text('Log'),
              ),
              FlatButton(
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                child: Text('Settings'),
              ),
              FlatButton(
                onPressed: () => Navigator.pushNamed(context, '/pray'),
                child: Text('Start Praying'),
              ),
              PrayerList(),
            ],
          )),
        ),
      ),
    );
  }
}
