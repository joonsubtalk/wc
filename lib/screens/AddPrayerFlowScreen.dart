import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/database_helper.dart';
import '../utils/styles.dart';
import '../widgets/CategoryItem.dart';
import '../models/prayer.dart';
import '../models/category.dart';

class AddPrayerFlowScreen extends StatefulWidget {
  @override
  _AddPrayerFlowScreenState createState() => _AddPrayerFlowScreenState();
}

class _AddPrayerFlowScreenState extends State<AddPrayerFlowScreen> {
  PrayerModel prayerModel;

  final PageController _pageController = PageController(initialPage: 0);

  final textController = TextEditingController();

  final dbHelper = DatabaseHelper.instance;

  int currentPrayerId;

  void _insertNewPrayer(String title, int categoryId) async {
    Map<String, dynamic> row = {
      DatabaseHelper.prayerTitle: title,
      DatabaseHelper.prayerCategory: categoryId,
    };
    final id = await dbHelper.insert(DatabaseHelper.prayerTable, row);
    currentPrayerId = id;
    prayerModel.add(Prayer(id, title, CATEGORY_LIST[categoryId]));
    print('inserted row id: $id');
  }

  @override
  void initState() {
    super.initState();
    textController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    textController.clear();
    textController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    prayerModel = ScopedModel.of<PrayerModel>(context, rebuildOnChange: true);
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
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (title) => prayerModel.setTitle(title),
                      controller: textController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Prayer Heading',
                          hintText: 'Who / what are you praying for?'),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text('Categories', style: h2Style),
                  SizedBox(height: 10.0),
                  Expanded(
                    flex: 1,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: CATEGORY_LIST.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 4.5 / 2.0),
                      itemBuilder: (context, index) {
                        return CategoryItem(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => {
                prayerModel.setCategory(null),
                textController.clear(),
                Navigator.pushNamed(context, '/'),
              },
            ),
            prayerModel.category != null && prayerModel.title != ''
                ? FlatButton(
                    child: Text('Add Prayer'),
                    onPressed: () {
                      _insertNewPrayer(
                          prayerModel.title, prayerModel.category.id);
                      // _pageController.nextPage(
                      //   duration: Duration(milliseconds: 500),
                      //   curve: Curves.ease,
                      // );
                    })
                : Text(''),
          ],
        ),
      ),
    );
  }
}
