import 'package:flutter/material.dart';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/models/app.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:fitlocker/widgets/widgets.dart';
import 'package:fitlocker/model.dart';

class HomeScreenModel extends Model {
  List<App> remoteApps = [];
  bool _isLoading = true;
  Future loadApps() async {
    this.remoteApps = await api.fetchApps();
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

class HomeScreen extends StatelessWidget {
  HomeScreenModel model;

  HomeScreen() {
    this.model = HomeScreenModel();
    this.model.loadApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home screen"),
      ),
      body: ScopedModel<HomeScreenModel> (
        model: model,
        child: Container(
          child: Center( 
            child: Padding( 
              padding: EdgeInsets.only(top: 30.0),
                child: Column(children: <Widget>[
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 10,
                        color: Colors.greenAccent[400]
                      )
                    ),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: Text("dupa dupa"),),
                    ),
                  ),
              ],)
            )         
          )
        )      
      ),
    );
  }
}
