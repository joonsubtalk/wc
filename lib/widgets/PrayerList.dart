import 'package:flutter/material.dart';
import 'package:wc/utils/database_helper.dart';

class PrayerList extends StatefulWidget {
  @override
  _PrayerListState createState() => _PrayerListState();
}

class _PrayerListState extends State<PrayerList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Container(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return Text('hello');
            },
          ),
        ),
      ),
    );
  }
}
