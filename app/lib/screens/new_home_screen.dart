import 'package:flutter/material.dart';

import 'package:fitlocker/widgets/widgets.dart';

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