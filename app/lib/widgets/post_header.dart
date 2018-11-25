import 'package:flutter/material.dart';
import 'package:fitlocker/model.dart';
import 'package:scoped_model/scoped_model.dart';

class PostHeaderWidget extends StatelessWidget {
  const PostHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: ScopedModel<PointsModel>(
          model: model,
          child: Column(
            children: <Widget>[
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 10, color: Colors.greenAccent[400])),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ScopedModelDescendant<PointsModel>(
                      builder: (context, child, model2222) => Center(
                            child: Text(model2222.points.toString()),
                          )),
                ),
              ),
            ],
          ),
        ));
  }
}
