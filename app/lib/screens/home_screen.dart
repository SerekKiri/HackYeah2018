import 'package:flutter/material.dart';
import 'package:fitlocker/api/api.dart';

class HomeScreen extends StatelessWidget {
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
