import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:async';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/utils/utils.dart';
import 'package:fitlocker/models/app.dart';
import 'package:fitlocker/widgets/widgets.dart';
import 'package:fitlocker/models/local_app.dart';
import 'package:fitlocker/model.dart';
import 'package:fitlocker/models/activity.dart';

import 'package:scoped_model/scoped_model.dart';

class ActivitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FitLocker'),
        ),
        body: ScopedModel<ActivityModel>(
            model: model,
            child: Scaffold(
                body: Center(child: ScopedModelDescendant<ActivityModel>(
              builder: (context, child, model) {
                if (model.activitiesLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemBuilder: (context, i) {
                        if (i.isOdd) return Divider();
                        final index = i ~/ 2;
                        return _buildActivity(index);
                      },
                      itemCount: model.activitites.length * 2);
                }
              },
            )))));
  }

  Widget _buildActivity(int index) {
    return ListTile(
        title: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(model.activitites[index].name,
                        style: TextStyle(fontSize: 16.0))),
                Text(model.activitites[index].calories.toString(),
                    style: TextStyle(fontSize: 16.0))
              ],
            )));
  }
}
