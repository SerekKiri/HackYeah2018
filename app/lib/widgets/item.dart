import 'package:flutter/material.dart';
import 'package:fitlocker/model.dart';

class ItemWidget extends StatelessWidget {
  final int index;

  ItemWidget({
    this.index
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(model.remoteApps[index].friendlyName,
                    style: TextStyle(fontSize: 16.0))),
                Text(model.remoteApps[index].costPerMinute.toString(),
                    style: TextStyle(fontSize: 16.0))
          ],
        )
      )
    );
  }
}