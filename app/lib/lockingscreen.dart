import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
class LockingScreen extends StatelessWidget {
  final String packageName;
  LockingScreen({this.packageName});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: () {
              SharedPreferences.getInstance().then((sp) async {
                await sp.setBool(packageName + '.unlocked', true);
SystemNavigator.pop();
              });
              
            },
            child: Text('Unlock'),)
          ],
        ),
      ),
    );
  }
}
