import 'package:flutter/material.dart';
import 'package:wc/models/request.dart';
import 'package:wc/widgets/RequestItem.dart';

class RequestList extends StatelessWidget {
  final List<Request> prayerRequests;
  RequestList(this.prayerRequests);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Container(
          child: ListView.builder(
            itemCount: prayerRequests.length,
            itemBuilder: (context, index) {
              return RequestItem(prayerRequests[index]);
            },
          ),
        ),
      ),
    );
  }
}
