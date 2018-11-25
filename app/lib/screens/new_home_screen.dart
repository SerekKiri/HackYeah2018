import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:async';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/utils/utils.dart';
import 'package:fitlocker/models/app.dart';
import 'package:fitlocker/screens/screens.dart';
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
        title: Text("FitLocker"),
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
