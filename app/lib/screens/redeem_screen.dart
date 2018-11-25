import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:async';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/models/app.dart';

import 'package:scoped_model/scoped_model.dart';


class AppCardsModel extends Model {
  List<App> remoteApps = [];
  bool _isLoading = true;
  Future loadApps() async {
    this.remoteApps = await api.fetchApps();
    this._isLoading = false;
    notifyListeners();
  }
}

class RedeemScreen extends StatelessWidget {
  AppCardsModel model;

  RedeemScreen() {
    this.model = AppCardsModel();
    this.model.loadApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FitLocker'),
      ),
      body: ScopedModel<AppCardsModel>(
        model: this.model,
        child: Center(
          child: ScopedModelDescendant<AppCardsModel>(
            builder: (context, child, model) {
              if (model._isLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 5.0),
                  itemBuilder: (context, i) {
                    return _buildApp(context, i, model);
                  },
                  itemCount: model.remoteApps.length,
                );
              }
            },
          )
        )
      )
    );
  }

  Widget _buildApp(BuildContext context, int index, AppCardsModel model) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Row(
              children: [
                Expanded(child: Text(model.remoteApps[index].friendlyName)),
                ButtonTheme(minWidth: 0.0, child: FlatButton(
                  child: Text('REDEEM POINTS', style: TextStyle(color: Colors.green[700])),
                  onPressed: () async {
                    var id = model.remoteApps[index].id;
                    var value = await showPointsChoiceDialog(context);
                    print('ID:');
                    print(id);
                    print('Value:');
                    print(value);
                    await api.redeemPoints(id, value);
                  }
                )),
              ]
            )
          ),
        ],
      ),
    );
  }
}

Future<int> showPointsChoiceDialog (context) {
  return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: const Text('Select assignment'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context, 5); },
            child: const Text('5'),
          ),
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context, 10); },
            child: const Text('10'),
          ),
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context, 15); },
            child: const Text('15'),
          ),
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context, 30); },
            child: const Text('30'),
          ),
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context, 60); },
            child: const Text('60'),
          ),
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context, 120); },
            child: const Text('120'),
          ),
        ],
      );
    }
  );
}