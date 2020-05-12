import 'package:flutter/material.dart';
import 'package:wc/utils/styles.dart';
import 'package:wc/widgets/RequestList.dart';
import '../models/prayer.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wc/models/prayer.dart';
import '../models/request.dart';
import '../utils/styles.dart';

class PrayerFull extends StatefulWidget {
  final Prayer prayer;

  PrayerFull(this.prayer);

  @override
  _PrayerFullState createState() => _PrayerFullState();
}

class _PrayerFullState extends State<PrayerFull> {
  RequestModel requestModel;
  PrayerModel prayerModel;
  bool _isEditing = false;
  bool _isUpdatingTitle = false;
  final textController = TextEditingController();
  final prayerTitleController = TextEditingController();

  @override
  void initState() {
    // setState(() {
    // });
    prayerTitleController.text = widget.prayer.title;
    print(prayerTitleController.text);
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    prayerModel = ScopedModel.of<PrayerModel>(context, rebuildOnChange: true);
    requestModel = ScopedModel.of<RequestModel>(context, rebuildOnChange: true);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _isUpdatingTitle
                    ? Expanded(
                        child: TextField(
                          autofocus: true,
                          controller: prayerTitleController,
                        ),
                      )
                    : Text(widget.prayer.title, style: prayer2Style),
                _isUpdatingTitle
                    ? Row(
                        children: <Widget>[
                          FlatButton(
                            child: Text('cancel'),
                            onPressed: () => {
                              setState(() => {_isUpdatingTitle = false})
                            },
                          ),
                          FlatButton(
                            child: Text('done'),
                            onPressed: () => {
                              setState(() => {_isUpdatingTitle = false})
                            },
                          ),
                        ],
                      )
                    : FlatButton(
                        child: Text('edit', style: smallStyle),
                        onPressed: () => {
                          setState(() => {_isUpdatingTitle = true})
                        },
                      ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Text(widget.prayer.category, style: smallStyle),
          SizedBox(height: 10.0),
          RequestList(prayerModel.prayers[widget.prayer.id - 1].requests),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () => {
                  setState(() => {_isEditing = !_isEditing}),
                  showBottomSheet(
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        height: 250.0,
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  autofocus: true,
                                  controller: textController,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () => {
                                      Navigator.pop(context),
                                      textController.clear(),
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  FlatButton(
                                    child: Text('hi'),
                                    onPressed: () =>
                                        {requestModel.query(widget.prayer.id)},
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      // requestModel.addRequest(
                                      //     textController.text,
                                      //     widget.prayer.id),
                                      prayerModel.addRequest(
                                          textController.text,
                                          widget.prayer.id),
                                      Navigator.pop(context),
                                      textController.clear(),
                                    },
                                    child: Text('Add Request'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                },
                child: Text('Add Request'),
              )
            ],
          )
        ],
      ),
    );
  }
}
