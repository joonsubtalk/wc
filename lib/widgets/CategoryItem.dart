import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:wc/models/category.dart';
import '../models/prayer.dart';
import '../utils/styles.dart';

class CategoryItem extends StatelessWidget {
  final int index;
  CategoryItem(this.index);

  @override
  Widget build(BuildContext context) {
    PrayerModel prayerModel =
        ScopedModel.of<PrayerModel>(context, rebuildOnChange: true);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ScopedModelDescendant<PrayerModel>(
            builder: (context, child, model) {
              return FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => {
                  model.setCategory(CATEGORY_LIST[index]),
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.5, vertical: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(
                        color: prayerModel.category?.id == index
                            ? Colors.blue
                            : Colors.white,
                      )),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            CATEGORY_LIST[index].title,
                            style: h2Style,
                          ),
                          SizedBox(height: 2.5),
                          Text(
                            CATEGORY_LIST[index].description,
                            style: smallStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
