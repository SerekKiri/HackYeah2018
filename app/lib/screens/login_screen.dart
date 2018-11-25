import 'package:fitlocker/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitlocker/api/api.dart';
import 'package:fitlocker/models/user.dart';

typedef void LoginCallback();

class LoginScreen extends StatelessWidget {
  final LoginCallback callback;
  LoginScreen(this.callback);

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
                  LoginForm(this.callback)
                ],
              ),
            ))
          ],
        ));
  }
}

class LoginForm extends StatelessWidget {
  final _loginFormKey = GlobalKey<FormState>();
  User userToLogIn = new User();
  final LoginCallback callback;
  LoginForm(this.callback);
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
                onSaved: (email) => userToLogIn.email = email,
              )),
          TextFormField(
            decoration: InputDecoration(hintText: "Password"),
            obscureText: true,
            onSaved: (password) => userToLogIn.password = password,
          ),
          Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: RaisedButton(
                onPressed: () async {
                  _loginFormKey.currentState.save();
                  var data = Map.from({
                    "email": userToLogIn.email,
                    "password": userToLogIn.password
                  });
                  (data);
                  if (!(await api.loginUser(data))) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text("Error!"),
                          content: new Text(
                              "Invalid username or password or your internet sucks."),
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
                  } else {
                    callback();
                  }
                },
                child: Text("Log in", style: TextStyle(color: Colors.white)),
                color: Theme.of(context).accentColor,
              )),
          FlatButton(
            child: Text("Register"),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            },
          )
        ],
      ),
    );
  }
}
