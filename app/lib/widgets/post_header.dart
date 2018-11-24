import 'package:flutter/material.dart';

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
