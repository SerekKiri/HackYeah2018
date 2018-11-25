import 'package:flutter/material.dart';
import 'package:fitlocker/screens/screens.dart';
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
            ItemWidget(index: 1,),
            ItemWidget(index: 2,),
            ItemWidget(index: 3,),
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