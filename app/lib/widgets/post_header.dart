import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:async';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/utils/utils.dart';
import 'package:fitlocker/models/app.dart';
import 'package:fitlocker/screens/screens.dart';

import 'package:scoped_model/scoped_model.dart';

class PostHeaderWidget extends StatelessWidget {
  const PostHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Column(children: <Widget>[
        Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 10,
            color: Colors.greenAccent[400]
          )
        ),
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(child: Text("dupa dupa"),),
        ),
      ),
      ],)       
    );
  }
}
