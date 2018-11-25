import 'package:flutter/material.dart';
import 'package:fitlocker/models/app.dart';

class AppWidget extends StatelessWidget {
  final App app;

  AppWidget({this.app});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Row(
          children: <Widget>[
            Text(app.friendlyName),
            Icon(Icons.euro_symbol),
            Text(app.costPerMinute.toString())
          ],
        ),
      ),
    );
  }
}