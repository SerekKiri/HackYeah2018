import 'package:flutter/material.dart';

import 'package:fitlocker/widgets/widgets.dart';
import 'package:fitlocker/model.dart';
import 'package:scoped_model/scoped_model.dart';

class NewHomeScreen extends StatelessWidget {
  NewHomeScreen() {
    model.loadApps();
    model.loadActivities();
    model.fetcherPointer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle: true,
          title: Text("Home", style: TextStyle(
            color: Colors.black
          ),),
          backgroundColor: Colors.white,
          elevation: 1.5,
        ),
        body: ListView(children: [
          ScopedModel<AppModel>(
              model: model,
              child: Container(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      PostHeaderWidget(),
                      ActivityCardWidget(),
                      ApplicationsCard(),
                    ],
                  ),
                ),
              ))
        ]));
  }
}
