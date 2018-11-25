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
  ActivitiesScreen() : super() {
    model.loadActivities();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FitLocker'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () {
                model.loadActivities();
              },
            ),
          ],
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
                        return ActivityListTile(index);
                      },
                      itemCount: model.activitites.length * 2);
                }
              },
            )))));
  }
}

class ActivityListTile extends StatelessWidget {
  final int index;

  ActivityListTile(this.index);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Padding(
            padding: EdgeInsets.fromLTRB(0.2, 0.8, 0.2, 0.8),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(model.activitites[index].name,
                        style: TextStyle(fontSize: 16.0)),
                    Text(
                      " ",
                      style: TextStyle(fontSize: 4),
                    ), // lololo spacing
                    Row(
                      children: <Widget>[
                        Text(model.activitites[index].niceDuration() + " ",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey)),
                        Text(
                            model.activitites[index].calories.toString() +
                                " kcal",
                            style: TextStyle(fontSize: 12.0))
                      ],
                    )
                  ],
                )),
                GetPointsButton(index)
              ],
            )));
  }
}

class GetPointsButton extends StatefulWidget {
  final int index;

  GetPointsButton(this.index);

  _GetPointsButtonState createState() => _GetPointsButtonState(index);
}

class _GetPointsButtonState extends State<GetPointsButton> {
  bool loading = false;
  bool alreadyConverted;

  int index;

  setLoading(loading) {
    setState(() {
      this.loading = loading;
    });
  }

  confirmConvert() {
    setState(() {
      this.alreadyConverted = true;
    });
  }

  _GetPointsButtonState(index) {
    this.index = index;
    alreadyConverted = model.activitites[index].alreadyConverted;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return CircularProgressIndicator();
    }
    if (alreadyConverted) {
      return Container(
          width: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  model.activitites[index].points.toString() +
                      " points received",
                  style: TextStyle(fontSize: 12, color: Colors.grey))
            ],
          ));
    }
    return Container(
      width: 125,
      child: RaisedButton(
        color: Colors.amber,
        child: Text(
            "Get " + model.activitites[index].points.toString() + " points"),
        onPressed: () async {
          setLoading(true);
          await api.convertActivity(model.activitites[index]);
          setLoading(false);
          confirmConvert();
          await model.fetcherPointer();
        },
      ),
    );
  }
}
