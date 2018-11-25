import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:async';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/utils/utils.dart';
import 'package:fitlocker/models/app.dart';
import 'package:fitlocker/screens/screens.dart';
import 'package:fitlocker/widgets/widgets.dart';
import 'package:fitlocker/model.dart';

final model = new AppModel();
class NewHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _createPointsHeader(context),
            _createActivityCard(context),
            _createReedemCard(context),
          ],

        ),
      ),
    ));
  }

  Widget _createPointsHeader(BuildContext context) {
    return new PostHeaderWidget();
  }


  Widget _createActivityCard(BuildContext context) {
    return new ActivityCardWidget();
  }


  Widget _createReedemCard(BuildContext context) {
    return new ApplicationsCard();
  }
}