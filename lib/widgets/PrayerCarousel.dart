import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wc/widgets/PrayerFull.dart';
import './PrayerFull.dart';
import '../models/prayer.dart';

class PrayerCarousel extends StatefulWidget {
  final List<Prayer> prayerList;
  PrayerCarousel(this.prayerList);

  @override
  _PrayerCarouselState createState() => _PrayerCarouselState(prayerList);
}

class _PrayerCarouselState extends State<PrayerCarousel> {
  List<Prayer> prayerList = [];
  final PageController _pageController = PageController(initialPage: 0);

  _PrayerCarouselState(this.prayerList);

  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < prayerList.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: isActive ? 20.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.black54,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          prayerList.isNotEmpty
              ? Expanded(
                  flex: 1,
                  child: PageView.builder(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: prayerList.length,
                    itemBuilder: (ctx, idx) => PrayerFull(prayerList[idx]),
                  ),
                )
              : Text('loading...'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          _currentPage != prayerList.length
              ? Container(
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ScopedModelDescendant<PrayerModel>(
                          builder: (context, child, model) {
                        return (FlatButton(
                          onPressed: () {
                            _currentPage != 0
                                ? _pageController.previousPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  )
                                : Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ));
                      }),
                      FlatButton(
                        onPressed: () {
                          _currentPage != prayerList.length - 1
                              ? _pageController.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                )
                              : Navigator.pushNamed(context, '/finish');
                        },
                        child: Text(
                          _currentPage != prayerList.length - 1
                              ? 'Next'
                              : 'Complete',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : FlatButton(
                  onPressed: () => {Navigator.pushNamed(context, '/finish')},
                  child: Text('finish'),
                ),
        ],
      ),
    );
  }
}
