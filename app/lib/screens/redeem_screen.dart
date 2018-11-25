import 'package:fitlocker/util.dart';
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
          title: Text('Redeem points', style: TextStyle(
            color: Colors.black
          ),),
          backgroundColor: Colors.white,
          elevation: 1.5,
          titleSpacing: 0,
          centerTitle: true,
        ),
        body: ScopedModel<AppCardsModel>(
            model: this.model,
            child: Center(child: ScopedModelDescendant<AppCardsModel>(
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
            ))));
  }

  Widget _buildApp(BuildContext context, int index, AppCardsModel model) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.album),
              title: Row(children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(model.remoteApps[index].friendlyName),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Text(
                        model.remoteApps[index].minutesLeft.floor().toString() +
                            " minutes left",
                        style: TextStyle(
                            color:
                                model.remoteApps[index].minutesLeft.floor() == 0
                                    ? Colors.grey
                                    : Colors.green),
                      ),
                    )
                  ],
                )),
                ButtonTheme(
                    minWidth: 0.0,
                    child: FlatButton(
                        child: Text('REDEEM POINTS',
                            style: TextStyle(color: Colors.green[700])),
                        onPressed: () async {
                          var id = model.remoteApps[index].id;
                          var value = await showPointsChoiceDialog(context);
                          var result = await api.redeemPoints(id, value);

                          if (result != null) {
                            showSimpleAlert(context, "Error", result);
                          } else {
                            await this.model.loadApps();
                          }
                        })),
              ])),
        ],
      ),
    );
  }
}

Future<int> showPointsChoiceDialog(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select the amount of minutes you want to buy'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 5);
              },
              child: const Text('5'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 10);
              },
              child: const Text('10'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 15);
              },
              child: const Text('15'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 30);
              },
              child: const Text('30'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 60);
              },
              child: const Text('60'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 120);
              },
              child: const Text('120'),
            ),
          ],
        );
      });
}
