import 'package:flutter/material.dart';
import 'package:wc/utils/styles.dart';

class FinishScreen extends StatelessWidget {
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
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Text(
                    'May the grace of the Lord jesus Christ and the sweet fellowship be with you now and forevermore.',
                    style: h1Style),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  child: Text('Home', style: prayer1Style),
                  onPressed: () => Navigator.pushNamed(context, '/'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
