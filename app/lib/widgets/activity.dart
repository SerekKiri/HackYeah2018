import 'package:flutter/material.dart';
import 'package:fitlocker/model.dart';

class ActivityWidget extends StatelessWidget {

  final int index;

  ActivityWidget({
    this.index
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(Icons.directions_run, size: 40.0,),
          Text(model.activitites[1].name)
        ],
      ),
    );
  }
}