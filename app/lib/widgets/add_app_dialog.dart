import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:async';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/utils/utils.dart';
import 'package:fitlocker/models/app.dart';
import 'package:fitlocker/screens/screens.dart';

import 'package:scoped_model/scoped_model.dart';

typedef void AddAppCallback(LocalApp app, int cost);

class AddAppDialog extends StatefulWidget {
  final List<LocalApp> apps;
  final AddAppCallback callback;
  AddAppDialog({this.apps, this.callback});

  _AddAppDialogState createState() => _AddAppDialogState();
}

class _AddAppDialogState extends State<AddAppDialog> {
  LocalApp selectedApp;
  int cost;
  @override
  Widget build(BuildContext context) {
    return new Column(mainAxisSize: MainAxisSize.min, children: [
      
      DropdownButton<LocalApp>(
        hint: Text('app to block'),
        value: selectedApp,
        items: widget.apps.map((LocalApp value) {
          return new DropdownMenuItem<LocalApp>(
            value: value,
            child: new Text(value.name),
          );
        }).toList(),
        onChanged: (index) {
          setState(() {
            selectedApp = index;
          });
        },
      ),
      TextField(decoration: InputDecoration(
        hintText: 'Select cost of the app'
      ), keyboardType: TextInputType.number, onChanged: (val) {
        cost = int.parse(val);
      },),
      FlatButton(onPressed: () {

        widget.callback(this.selectedApp, this.cost);
      }, child: Text('Add app')),
    ]);
  }
}
