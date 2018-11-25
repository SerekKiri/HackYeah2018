import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LockingScreen extends StatelessWidget {
  final String packageName;
  LockingScreen({this.packageName});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LockingScreenWidget(packageName: this.packageName),
    );
  }
}

class LockingScreenWidget extends StatelessWidget {
  final String packageName;
  LockingScreenWidget({this.packageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(packageName),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Image.asset("assets/logo.png", width: 200, height: 200,),
            Text("Time is out!", style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),),
            Container(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Icon(Icons.shop, color: Colors.white,),
                          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                        ),
                        Text("Buy more time!")
                      ],
                    ),
                  ),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Convert your points")
                      ],
                    ),
                  ),
                ],
              ),
            )            
          ],
        ),
      ),
    );
  }
}
