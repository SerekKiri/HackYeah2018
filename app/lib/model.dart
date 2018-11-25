import 'package:scoped_model/scoped_model.dart';
import 'package:fitlocker/models/local_app.dart';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/utils/utils.dart';
import 'package:fitlocker/models/app.dart';
import 'package:fitlocker/models/activity.dart';

class AppModel extends Model with AppListModel, ActivityModel, PointsModel {

  AppModel() {
    this.loadApps();
  }
}

abstract class AppListModel extends Model {
  List<App> remoteApps = [];
  List<LocalApp> localApps = [];
  bool isLoading = true;
  Future loadApps() async {
    if (this.remoteApps.isNotEmpty) return;
    this.remoteApps = await api.fetchApps();
    this.remoteApps.forEach((app) {
      supaPrefs.getPrefs().setBool(app.appIndentifier, true);

    }
    );
    this.localApps = await getAppList();

    this.isLoading = false;
    notifyListeners();
  }
  Future addApp(LocalApp app, int cost) async {
    await api.addApp(app.name, app.packageName, cost);
    this.remoteApps = await api.fetchApps();
    this.localApps = await getAppList();

    this.isLoading = false;
    notifyListeners();
  }
}


abstract class ActivityModel extends Model {
  List<Activity> activitites = [];
  bool activitiesLoading = true;
  Future loadApps() async {
    this.activitites = await api.getConvertableActivities();

    this.activitiesLoading = false;
    notifyListeners();
  }
}

abstract class PointsModel extends Model {
}

final model = new AppModel();
