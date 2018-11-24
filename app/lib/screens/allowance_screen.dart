import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:async';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/utils/utils.dart';
import 'package:fitlocker/models/app.dart';
import 'package:fitlocker/widgets/widgets.dart';

import 'package:scoped_model/scoped_model.dart';

Future<List<LocalApp>> getAppList() async {
  await supaPrefs.init();
  var apps = List<String>.from(await platform.invokeMethod('queryPackages'));
  print(apps);
  List<LocalApp> unsortedApps = List<LocalApp>.from(apps.map((String app) {
    var blocked = false;
    try {
      blocked = supaPrefs.getPrefs().getBool(app.split(';')[1]);
    } catch (e) {}
    if (!(blocked is bool)) blocked = false;
    return LocalApp(app.split(';')[0], app.split(';')[1], blocked);
  }).toList());

  unsortedApps.sort();
  return unsortedApps;
}

class LocalApp extends Comparable {
  String name;
  String packageName;
  bool isBlocked;

  LocalApp(this.name, this.packageName, this.isBlocked);

  @override
  int compareTo(other) {
    if (other.name == null || this.name == null) return 0;
    return this.name.compareTo(other.name);
  }
}

class AppListModel extends Model {
  List<App> remoteApps = [];
  List<LocalApp> localApps = [];
  bool _isLoading = true;
  Future loadApps() async {
    this.remoteApps = await api.fetchApps();
    this.localApps = await getAppList();

    this._isLoading = false;
    notifyListeners();
  }
  Future addApp(LocalApp app, int cost) async {
    await 
    await api.addApp(app.name, app.packageName, cost);
    this.remoteApps = await api.fetchApps();
    this.localApps = await getAppList();

    this._isLoading = false;
    notifyListeners();
  }
  Future load() async {
    //await api.fetchApps();
    //this.storagedApps = await getAppList();
    //this._isLoading = false;
    //notifyListeners();
  }
  void toggleApp(int index) async {
    // App app = storagedApps[index];
    // await supaPrefs.getPrefs().setBool(app.packageName, !app.isBlocked);
    // app.isBlocked = !app.isBlocked;
    // notifyListeners();
  }
}

class AllowanceScreen extends StatelessWidget {
  AppListModel model;

  AllowanceScreen() {
    this.model = AppListModel();
    this.model.loadApps();
  }
  void _showDialog(AppListModel model, BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text('Add new app to track'),
          content: new AddAppDialog(callback: (app, cost) {
            this.model.addApp(app, cost);
            Navigator.of(context).pop();
          }, apps: this.model.localApps),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FitLocker'),
        ),
        body: ScopedModel<AppListModel>(
            model: this.model,
            child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    _showDialog(model, context);
                  },
                ),
                body: Center(child: ScopedModelDescendant<AppListModel>(
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
                          itemCount: model.remoteApps.length * 2);
                    }
                  },
                )))));
  }

  Widget _buildApp(int index, AppListModel model) {
    return ListTile(
        title: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(model.remoteApps[index].friendlyName,
                        style: TextStyle(fontSize: 16.0))),
                Text(model.remoteApps[index].costPerMinute.toString(),
                    style: TextStyle(fontSize: 16.0))
              ],
            )));
  }
}
