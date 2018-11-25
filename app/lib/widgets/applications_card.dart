import 'package:flutter/material.dart';
import 'package:fitlocker/screens/screens.dart';
import 'package:fitlocker/model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'widgets.dart';

class ApplicationsCard extends StatelessWidget {
  const ApplicationsCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Card(
            elevation: 0,
            child: Column(
              children: <Widget>[
                ScopedModel<AppListModel>(
                    model: model,
                    child: ScopedModelDescendant<AppListModel>(
                      builder: (context, child, model121) {
                        var items = 3;
                        if (model121.remoteApps.length < items) {
                          items = model121.remoteApps.length;
                        }
                        return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10.0),
                            itemBuilder: (context, i) {
                              if (i.isOdd) return Divider();
                              final index = i ~/ 2;
                              return ItemWidget(index: index);
                            },
                            itemCount: items * 2);
                      },
                    )),
                FlatButton(
                  child: Text('More'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllowanceScreen()));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
