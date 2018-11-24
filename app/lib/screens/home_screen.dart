import 'package:flutter/material.dart';
import 'package:fitlocker/api/api.dart';

class homeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RaisedButton(
          onPressed: api.fetchApps,
        ),
      ),
    );
  }
}
