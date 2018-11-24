import 'package:flutter/material.dart';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/models/user.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class loginScreen extends StatelessWidget {
  final _loginFormKey = GlobalKey<FormState>();
  User userToLogIn = new User();

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
                        onSaved: (email) => userToLogIn.email = email,
                      ),),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "password"
                      ),
                      onSaved: (password) => userToLogIn.password = password,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: RaisedButton(
                        onPressed: () {
                          _loginFormKey.currentState.save();
                          var data = Map.from({
                            "email" : userToLogIn.email,
                            "password": userToLogIn.password
                          });
                          print(data);
                          api.loginUser(data);
                        },
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
