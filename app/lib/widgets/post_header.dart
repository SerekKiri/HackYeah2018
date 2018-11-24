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
      padding: const EdgeInsets.all(50.0),
      child: Container(
        
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green, width: 20)),
        child: Container(
          child: Center(child: Text('DUPA', style: TextStyle(fontSize: 32.0),)),
          height: 150, width: 150,),
      ),
    );
  }
}
