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
                    return _buildApp(i, model);
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

  Widget _buildApp(int index, AppCardsModel model) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Row(
              children: [
                Expanded(child: Text(model.remoteApps[index].friendlyName)),
                ButtonTheme(minWidth: 0.0, child: FlatButton(child: Text('REDEEM POINTS', style: TextStyle(color: Colors.green[700])), onPressed: () {  })),
              ]
            )
          ),
        ],
      ),
    );
  }
}
