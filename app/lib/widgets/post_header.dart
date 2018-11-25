import 'package:flutter/material.dart';
import 'package:fitlocker/model.dart';
import 'package:fitlocker/screens/redeem_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class PostHeaderWidget extends StatelessWidget {
  const PostHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: ScopedModel<PointsModel>(
          model: model,
          child: Column(
            children: <Widget>[
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 8.0,
                    color: Colors.greenAccent[400]
                  )
                ),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ScopedModelDescendant<PointsModel>(
                    builder: (context, child, model2222) => Center(
                      child: Text(
                        model2222.points.toString(),
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold
                        )
                      )
                    )
                  ),
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => RedeemScreen())
        );
      }
    );
  }
}
