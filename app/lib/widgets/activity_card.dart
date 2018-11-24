import 'package:flutter/material.dart';

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
            Text('BIEGANKA'),
            Row(
              children: <Widget>[
                Icon(Icons.directions_run, size: 40.0,),
                Text('BIEGANKO 5 MIN')
              ],
            ),
                        Row(
              children: <Widget>[
                Icon(Icons.directions_run, size: 40.0,),
                Text('BIEGANKO 5 MIN')
              ],
            ),
                        Row(
              children: <Widget>[
                Icon(Icons.directions_run, size: 40.0,),
                Text('BIEGANKO 5 MIN')
              ],
            )
            
          ],
        ),
      ),
    ));
  }
}

