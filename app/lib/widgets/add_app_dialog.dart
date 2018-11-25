import 'package:flutter/material.dart';

import 'package:fitlocker/models/local_app.dart';

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
    return SimpleDialog(title: const Text('Add a new app to track'), children: [
      SimpleDialogOption(
        child: Row(children: [DropdownButton<LocalApp>(
          hint: Text('App to block'),
          value: selectedApp,
          items: widget.apps.map((LocalApp value) {
            return new DropdownMenuItem<LocalApp>(
              value: value,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  value.icon,
                  Container(child: Text(value.name, overflow: TextOverflow.ellipsis), width: 180)
                ]
              ),
            );
          }).toList(),
          onChanged: (index) {
            setState(() {
              selectedApp = index;
            });
          },
        )]),
      ),
      SimpleDialogOption(
        child: TextField(
          decoration:
              InputDecoration(hintText: 'Cost of a minute using the app'),
          keyboardType: TextInputType.number,
          onChanged: (val) {
            cost = int.parse(val);
          })
      ),
      SimpleDialogOption(
        child: FlatButton(
          onPressed: () {
            widget.callback(this.selectedApp, this.cost);
          },
          child: Text('Add app')), 
      ),
    ]);
  }
}
