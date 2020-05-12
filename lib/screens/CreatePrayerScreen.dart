import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wc/utils/styles.dart';
import 'package:wc/widgets/CategoryItem.dart';
import '../models/category.dart';
import '../models/prayer.dart';
import '../utils/database_helper.dart';

class CreatePrayerScreen extends StatefulWidget {
  @override
  _CreatePrayerScreenState createState() => _CreatePrayerScreenState();
}

class _CreatePrayerScreenState extends State<CreatePrayerScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final textController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;

  // String title = _titleController.text;
  int _currentPage = 0;
  int _numPages = 3;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.black54,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.prayerTitle: '',
      DatabaseHelper.prayerCategory: 0
    };
    final id = await dbHelper.insert(DatabaseHelper.prayerTable, row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows('prayers');
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
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
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextField(
                                  controller: textController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      labelText: 'Title',
                                      hintText:
                                          'Who / what are you praying for?'),
                                ),
                                SizedBox(height: 10.0),
                                Text('Categories:', style: h2Style),
                                SizedBox(height: 10.0),
                                Expanded(
                                  flex: 1,
                                  child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: CATEGORY_LIST.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 5.0 / 1.75),
                                    itemBuilder: (context, index) {
                                      return Text('hi');
                                      // return CategoryItem(index, _pageController);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ScopedModelDescendant<PrayerModel>(
                            builder: (context, child, model) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 30.0),
                                    Text(model.title.toString()),
                                    SizedBox(height: 15.0),
                                    TextField(
                                      keyboardType: TextInputType.text,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Title',
                                          hintText: 'Enter a search term'),
                                    ),
                                    SizedBox(height: 15.0),
                                    TextField(
                                      keyboardType: TextInputType.text,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Request',
                                          hintText: 'Enter a type'),
                                    ),
                                    RaisedButton(
                                      child: Text(
                                        'Insert',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () {
                                        print('hi');
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 30.0),
                                Text(
                                  'Get a new experience\nof imagination',
                                ),
                                SizedBox(height: 15.0),
                                FlatButton(
                                  child: Text('query'),
                                  onPressed: () => _query(),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    _currentPage != _numPages
                        ? Container(
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _currentPage != 0
                                    ? ScopedModelDescendant<PrayerModel>(
                                        builder: (context, child, model) {
                                        return (FlatButton(
                                          onPressed: () {
                                            _pageController.previousPage(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          },
                                          child: Text(
                                            'Back',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ));
                                      })
                                    : FlatButton(
                                        onPressed: () =>
                                            Navigator.pushNamed(context, '/'),
                                        child: Text('back')),
                                FlatButton(
                                  onPressed: () {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  },
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(''),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
