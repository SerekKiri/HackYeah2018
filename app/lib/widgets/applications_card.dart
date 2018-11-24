import 'package:flutter/material.dart';

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
            Text('APLIKACJE'),
            Row(
              children: <Widget>[
                Icon(Icons.message, size: 40.0,),
                Text('FaCEBOOK')
              ],
            ),
                        Row(
              children: <Widget>[
                Icon(Icons.message, size: 40.0,),
                Text('FaCEBOOK')
              ],
            ),
                        Row(
              children: <Widget>[
                Icon(Icons.message, size: 40.0,),
                Text('FaCEBOOK')
              ],
            )
            
          ],
        ),
      ),
    ));
  }
}