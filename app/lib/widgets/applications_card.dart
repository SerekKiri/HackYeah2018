import 'package:flutter/material.dart';
import 'package:fitlocker/screens/screens.dart';

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
            Text('Apps'),
            Row(
              children: <Widget>[
                Icon(Icons.message, size: 40.0,),
                Text('Facebook')
              ],
            ),
                        Row(
              children: <Widget>[
                Icon(Icons.message, size: 40.0,),
                Text('Facebook')
              ],
            ),
                        Row(
              children: <Widget>[
                Icon(Icons.message, size: 40.0,),
                Text('Facebook')
              ],
            ),
            FlatButton(child: Text('More'), onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AllowanceScreen()
                )
              );
            },)
            
          ],
        ),
      ),
    ));
  }
}