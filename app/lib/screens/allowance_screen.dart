import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:async';
import 'package:fitlocker/utils/utils.dart';
import 'package:scoped_model/scoped_model.dart';

Future<List<App>> getAppList () async {
  await supaPrefs.init();
  var apps = List<String>.from(await platform.invokeMethod('queryPackages'));
  print(apps);
  List<App> unsortedApps = List<App>.from(
    apps
      .map((String app) {
        var blocked = false;
        try {
          blocked = supaPrefs.getPrefs().getBool(app.split(';')[1]);
        } catch (e) {}
        if (!(blocked is bool)) blocked = false;
        return App(app.split(';')[0], app.split(';')[1], blocked);
      })
      .toList()
  );

  unsortedApps.sort();
  return unsortedApps;
}

class App extends Comparable {
  String name;
  String packageName;
  bool isBlocked;

  App(this.name, this.packageName, this.isBlocked);

  @override
    int compareTo(other) {
      if (other.name == null || this.name == null) return 0;
      return this.name.compareTo(other.name);
    }
}

class AppListModel extends Model {
  List<App> apps = [];
  bool _isLoading = true;
  Future loadApps() async {
    this.apps = await getAppList();
    this._isLoading = false;
    notifyListeners();
  }

  void toggleApp(int index) async {
    await supaPrefs.getPrefs().setBool(apps[index].packageName, !apps[index].isBlocked);
    apps[index].isBlocked = !apps[index].isBlocked;
    notifyListeners();
  }
}

class AllowanceScreen extends StatelessWidget {
  AppListModel model;

  AllowanceScreen() {
    this.model = AppListModel();
    this.model.loadApps();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FitLocker'),
      ),
      body: ScopedModel<AppListModel>(
        model: this.model,
        child: Center(
          child: ScopedModelDescendant<AppListModel>(
            builder: (context, child, model) {
              if (model._isLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                  return ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemBuilder: (context, i) {
                      if (i.isOdd) return Divider();
                      final index = i ~/ 2;
                      return _buildApp(index, model);
                    },
                    itemCount: model.apps.length * 2
                  );
              }
            },
          )
        )
      )
    );
  }

  Widget _buildApp(int index, AppListModel model) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children:<Widget>[
            Expanded(
              child: Text(model.apps[index].name, style: TextStyle(fontSize: 16.0))
            ),
            Switch(
              value: model.apps[index].isBlocked,
              onChanged: (bool value) {
                model.toggleApp(index);
              },
            ),
          ],
        )
      )
    );
  }
}
