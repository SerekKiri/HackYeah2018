import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:fitlocker/lockingscreen.dart';
import 'package:fitlocker/screens/screens.dart';
import 'package:fitlocker/utils/utils.dart';

void main() => supaPrefs.init().then((d) async { 
  var loggedIn = false;
  try {
    loggedIn = supaPrefs.getPrefs().getString('token') is String;
  } catch (e) {}
  if (!(loggedIn is bool)) {
    loggedIn = false;
  } 
  if (!loggedIn) {}
  
  
  runApp(FitLocker(loggedIn)); 
});
void lockingscreen() => supaPrefs.init().then((d) { runApp(LockingScreen(packageName: window.defaultRouteName)); });

class FitLocker extends StatelessWidget {
  final bool loggedIn;
  FitLocker(this.loggedIn);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitLocker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(loggedIn),
    );
  }
}

class MainScreen extends StatefulWidget {
  final bool loggedIn;
  MainScreen(this.loggedIn);
  
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool reallyloggedin = false;
  final List<Widget> _children = [AllowanceScreen(),NewHomeScreen(), RedeemScreen() ];
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.loggedIn && !this.reallyloggedin) {
      return Scaffold(
        body: LoginScreen(() {
          setState(() {
            reallyloggedin = true;
          });
        })
      );
    }
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
                icon: Icon(Icons.home),
                onPressed: () => this.setState(() { this._currentIndex = 1; }),
                color: Color(_currentIndex == 1 ? 0xff3c84c1 : 0xff666666),
              ),
              IconButton(
                icon: Icon(Icons.shop),
                onPressed: () => this.setState(() { this._currentIndex = 2; }),
                color: Color(_currentIndex == 2 ? 0xff3c84c1 : 0xff666666),
              ),
            ],
          ),
        )
      )
    );
  }
}