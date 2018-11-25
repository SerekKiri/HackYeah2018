import 'package:flutter/material.dart';
import 'package:fitlocker/screens/screens.dart';
import 'widgets.dart';

class ActivityCardWidget extends StatelessWidget {
  const ActivityCardWidget({
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
                ActivityListTile(0),
                Divider(),
                ActivityListTile(1),
                Divider(),
                ActivityListTile(2),
                Divider(),
                FlatButton(
                  child: Text('More'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ActivitiesScreen()));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
