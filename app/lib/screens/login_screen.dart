import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget {
  final _loginFormKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text("FitLocker", style: TextStyle(
                  fontSize: 40.0
                  )
                ),
              ),
              Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "email"
                        ),
                      ),),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "password"
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("Log in", style: TextStyle(
                          color: Colors.white
                        )),
                        color: Theme.of(context).accentColor,
                    ))
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}

