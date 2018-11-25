import 'package:flutter/material.dart';
import 'package:fitlocker/model.dart';

class ItemWidget extends StatelessWidget {
  final int index;

  ItemWidget({this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                 this.iconForId(model.remoteApps[index].appIndentifier),
                
                Expanded(
                    child: Text(model.remoteApps[index].friendlyName,
                        style: TextStyle(fontSize: 16.0))),
                Text(model.remoteApps[index].costPerMinute.toString(),
                    style: TextStyle(fontSize: 16.0)),
                
              ],
      )));
  }

  Widget iconForId(String pkgName) {
    var ddd = model.localApps.toList().firstWhere((e) {
      return e.packageName == pkgName;
    }, orElse: () => null);
    if (ddd != null) {
      return Container(
                  width: 50.0,
                  height: 50.0,
                  padding: EdgeInsets.only(right: 5.0),
                  child:ddd.icon);
    } else
    return Container();
  }
}
