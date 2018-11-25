import 'package:flutter/material.dart';
import 'package:fitlocker/widgets/widgets.dart';
import 'dart:ui';
import 'dart:async';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/utils/utils.dart';
import 'package:fitlocker/models/app.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreenModel extends Model {
  List<App> remoteApps = [];
  Future loadApps() async {
    this.remoteApps = await api.fetchApps();
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FitLocker", style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Colors.blue,
         iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
        body: Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _createPointsHeader(context),
            _createActivityCard(context),
            _createReedemCard(context),
          ],
        ),
      ),
    ));
  }

  Widget _createPointsHeader(BuildContext context) {
    return new PostHeaderWidget();
  }

  Widget _createActivityCard(BuildContext context) {
    return new ActivityCardWidget();
  }

  Widget _createReedemCard(BuildContext context) {
    return new ApplicationsCard();
  }
}
