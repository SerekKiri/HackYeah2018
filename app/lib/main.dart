import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:fitlocker/lockingscreen.dart';
import 'package:fitlocker/screens/screens.dart';

void main() => runApp(FitLocker());
void lockingscreen() => runApp(LockingScreen(packageName: window.defaultRouteName));

class FitLocker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitLocker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {

  @override
    State<StatefulWidget> createState() {
      return _MainScreenState();
    }
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [AllowanceScreen(), Text('todo xD') ];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomAppBar(
            child: new Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.lock),
                onPressed: () => this.setState(() { this._currentIndex = 0; }),
                color: Color(_currentIndex == 0 ? 0xff3c84c1 : 0xff666666),
              ),
              IconButton(
                icon: Icon(Icons.shop),
                onPressed: () => this.setState(() { this._currentIndex = 1; }),
                color: Color(_currentIndex == 1 ? 0xff3c84c1 : 0xff666666),
              ),
            ],
          ),
        )));
  }
}