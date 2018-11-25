import 'package:scoped_model/scoped_model.dart';
import 'package:fitlocker/models/local_app.dart';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/utils/utils.dart';
import 'package:fitlocker/models/app.dart';

class AppModel extends Model with AppListModel, ActivityModel, PointsModel {}

abstract class AppListModel extends Model {
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
}


abstract class ActivityModel extends Model {
  List<App> remoteApps = [];
  List<LocalApp> localApps = [];
  bool _isLoading = true;
  Future loadActivities() async {
    this.remoteApps = await api.fetchApps();
    this.localApps = await getAppList();

    this._isLoading = false;
    notifyListeners();
  }
}

abstract class PointsModel extends Model {
  List<App> remoteApps = [];
  List<LocalApp> localApps = [];
  bool _isLoading = true;
  Future loadActivities() async {
    this.remoteApps = await api.fetchApps();
    this.localApps = await getAppList();

    this._isLoading = false;
    notifyListeners();
  }
}