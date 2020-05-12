import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wc/models/prayer.dart';

class SettingScreen extends StatelessWidget {
  PrayerModel prayerModel;
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
              children: <Widget>[
                Text('hi, i am the setting page'),
                FlatButton(
                  onPressed: () => prayerModel.deletePrayers(),
                  child: Text('Clear Prayers'),
                ),
                FlatButton(
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  child: Text('back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
