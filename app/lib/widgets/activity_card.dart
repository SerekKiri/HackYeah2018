import 'package:flutter/material.dart';
import 'package:fitlocker/screens/screens.dart';
import 'widgets.dart';
import 'package:fitlocker/model.dart';
import 'package:scoped_model/scoped_model.dart';

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
            elevation: 2,
            child: Column(
              children: <Widget>[
                Container(padding: EdgeInsets.all(12.0), child: Text('Activities', style: TextStyle(fontSize: 16.0))),
                Divider(),
                ScopedModel<ActivityModel>(
                  model: model,
                  child: ScopedModelDescendant<ActivityModel>(
                    builder: (context, child, model5) {
                      var items = 3;
                      if (model.activitiesLoading == true) {
                        return CircularProgressIndicator();
                      }
                      if (model5.activitites.length < items) {
                        items = model5.activitites.length;
                      }
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10.0),
                        itemBuilder: (context, i) {
                          if (i.isOdd) return Divider();
                          final index = i ~/ 2;
                          return ActivityListTile(index);
                        },
                        itemCount: items * 2
                      );
                    },
                  )
                ),
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
