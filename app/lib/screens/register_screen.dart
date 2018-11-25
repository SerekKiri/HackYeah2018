import 'package:fitlocker/screens/login_screen.dart';
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
  static GlobalKey<FormState> emailKey = new GlobalKey<FormState>();
  static GlobalKey<FormState> displayNameKey = new GlobalKey<FormState>();
  static GlobalKey<FormState> passwordKey = new GlobalKey<FormState>();
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
                key: emailKey,
                decoration: InputDecoration(hintText: "Email"),
                onSaved: (email) => userToRegister.email = email,
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: TextFormField(
              key: displayNameKey,
              decoration: InputDecoration(hintText: "Display name"),
              onSaved: (displayName) =>
                  userToRegister.displayName = displayName,
            ),
          ),
          TextFormField(
            key: passwordKey,
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
                  if (await api.registerUser(data)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text("Success!"),
                          content: new Text("You may now login!"),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text("Error!"),
                          content: new Text(
                              "Please check if your email is correct and unique! Additionally the password must be at least 6 characters long."),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text("Register", style: TextStyle(color: Colors.white)),
                color: Theme.of(context).accentColor,
              )),
          FlatButton(
            child: Text("Log in"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
