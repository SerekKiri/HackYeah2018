import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui';
import 'dart:async';
import 'package:fitlocker/lockingscreen.dart';
import 'package:fitlocker/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'supaprefs.dart';

void main() => runApp(MyApp());
void lockingscreen() => runApp(LockingScreen(packageName: window.defaultRouteName));
const platform = const MethodChannel('feelfreelinux.github.io/fitlocker');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitLocker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppList(),
    );
  }
}

class App extends Comparable {
  String name;
  String packageName;

  App(this.name, this.packageName);

  @override
    int compareTo(other) {
      // TODO: implement compareTo
      if (other.name == null || this.name == null) {
        return 0;
      }
      return this.name.compareTo(other.name);
    }
}

class AppList extends StatelessWidget {
  Future<dynamic> getAppList () async {
    await supaPrefs.init();
    final apps = await platform.invokeMethod('queryPackages');
    final unsortedApps = apps
      .map((app) {
        print(app);
        return App(app.split(';')[0], app.split(';')[1]);
      })
      .toList();
    unsortedApps.sort();
    return unsortedApps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FitLocker'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getAppList(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none: return Center(child: Text('Waiting to start'));
              case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
                return ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemBuilder: (context, i) {
                    if (i.isOdd) return Divider();
                    final index = i ~/ 2;
                    return SingleAppWidget(app: snapshot.data[index]);
                  },
                  itemCount: snapshot.data.length * 2
                );
            }
          },
        )
      )
    );
  }
}

class SingleAppWidget extends StatelessWidget {
  const SingleAppWidget({
    Key key,
    @required App this.app,
  }) : super(key: key);

  final App app;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children:<Widget>[
            Expanded(
              child: Text(app.name, style: TextStyle(fontSize: 16.0))
            ),
            Switch(
              value: false,
              onChanged: (bool value) {
                print('dupa');
                supaPrefs.getPrefs().setBool(app.packageName, value);
              },
            ),
          ],
        )
      )
    );
  }
}
