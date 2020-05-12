import 'package:flutter/material.dart';
import 'package:wc/utils/styles.dart';
import '../models/request.dart';

class RequestItem extends StatefulWidget {
  final Request request;
  RequestItem(this.request);

  @override
  _RequestItemState createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  bool isEditing = false;

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
            child: Text('${widget.request.toString()}', style: prayer1Style)),
        FlatButton(
          onPressed: () => _toggleEditMode(),
          child: Icon(
            Icons.more_vert,
          ),
        ),
      ],
    ));
  }
}
