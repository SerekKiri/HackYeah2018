import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui';
import 'package:applocker/lockingscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());
void lockingscreen() => runApp(LockingScreen(packageName: window.defaultRouteName));
const platform = const MethodChannel('feelfreelinux.github.io/applocker');

class MyApp extends StatelessWidget {
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
      home: AppList(),
    );
  }
}


class AppList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('FitLocker'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FutureBuilder(
          future: platform.invokeMethod('queryPackages'),
          builder: (context, result) {
            if (result.hasData) {
              return ListView.builder(
                itemCount: result.data.length,
                itemBuilder: (context, index) {
                  return Text(result.data[index]);
                },
              );
            }
            return Text('wololo');
          },
        )
    )
    );
  }
}
