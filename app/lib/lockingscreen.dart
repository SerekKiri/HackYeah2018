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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                SharedPreferences.getInstance().then((sp) async {
                  await sp.setBool(packageName + '.unlocked', true);
                  SystemNavigator.pop();
                });
              },
              child: Text('Unlock'),
            )
          ],
        ),
      ),
    );
  }
}
