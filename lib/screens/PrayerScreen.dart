import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:wc/widgets/PrayerCarousel.dart';
import '../models/prayer.dart';

class PrayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PrayerModel prayerModel =
        ScopedModel.of<PrayerModel>(context, rebuildOnChange: true);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
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
          child: SafeArea(child: PrayerCarousel(prayerModel.prayers)),
        ),
      ),
    );
  }
}
