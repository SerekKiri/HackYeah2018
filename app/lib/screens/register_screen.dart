import 'package:flutter/material.dart';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/models/user.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(
          children: <Widget>[
            Center(
                child: Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Image.asset(
                            "assets/logo.png",
                            width: 200,
                            height: 200,
                          ),
                        ),
                        Text("FitLocker", style: TextStyle(fontSize: 40.0)),
                      ])),
                  RegisterForm()
                ],
              ),
            ))
          ],
        ));
  }
}

class RegisterForm extends StatelessWidget {
  final _loginFormKey = GlobalKey<FormState>();
  User userToRegister = new User();
  RegisterForm();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "Email"),
                onSaved: (email) => userToRegister.email = email,
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Display name"),
              onSaved: (displayName) =>
                  userToRegister.displayName = displayName,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(hintText: "Password"),
            obscureText: true,
            onSaved: (password) => userToRegister.password = password,
          ),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: RaisedButton(
                onPressed: () async {
                  _loginFormKey.currentState.save();
                  var data = Map.from({
                    "email": userToRegister.email,
                    "password": userToRegister.password,
                    "displayName": userToRegister.displayName
                  });
                  await api.registerUser(data);
                },
                child: Text("Register", style: TextStyle(color: Colors.white)),
                color: Theme.of(context).accentColor,
              ))
        ],
      ),
    );
  }
}
