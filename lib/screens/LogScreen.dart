import 'package:flutter/material.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                Text('hi, i am the log'),
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
