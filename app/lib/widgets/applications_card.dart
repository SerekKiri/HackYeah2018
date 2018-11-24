import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:async';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/utils/utils.dart';
import 'package:fitlocker/models/app.dart';
import 'package:fitlocker/screens/screens.dart';

import 'package:scoped_model/scoped_model.dart';

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