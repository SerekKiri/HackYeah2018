import 'package:flutter/material.dart';

import 'package:fitlocker/screens/screens.dart';

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
    return Column(mainAxisSize: MainAxisSize.min, children: [
      DropdownButton<LocalApp>(
        hint: Text('App to block'),
        value: selectedApp,
        items: widget.apps.map((LocalApp value) {
          return new DropdownMenuItem<LocalApp>(
            value: value,
            child: Row(children: [ value.icon, Text(value.name) ] ),
          );
        }).toList(),
        onChanged: (index) {
          setState(() {
            selectedApp = index;
          });
        },
      ),
      TextField(decoration: InputDecoration(
        hintText: 'Cost of a minute using the app'
      ), keyboardType: TextInputType.number, onChanged: (val) {
        cost = int.parse(val);
      }),
      FlatButton(onPressed: () {
        widget.callback(this.selectedApp, this.cost);
      }, child: Text('Add app')),
    ]);
  }
}
