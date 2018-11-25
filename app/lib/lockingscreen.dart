import 'package:fitlocker/screens/activity_screen.dart';
import 'package:fitlocker/screens/redeem_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LockingScreen extends StatelessWidget {
  final String packageName;
  LockingScreen({this.packageName});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LockingScreenWidget(packageName: this.packageName),
    );
  }
}

class LockingScreenWidget extends StatelessWidget {
  final String packageName;
  LockingScreenWidget({this.packageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1.5,
        centerTitle: true,
        title: Text("FitLocker", style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/logo.png",
                width: 200,
                height: 200,
              ),
              Text(" "),
              Text(
                "Time is out. Get moving!",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(" "),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 250,
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              child: Icon(
                                Icons.shop,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.only(
                                  right: 10.0, bottom: 10.0, top: 10),
                            ),
                            Text(
                              "Buy more time!\n",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        onPressed: () {

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RedeemScreen()));
                        },
                      ),
                    ),
                    Container(
                      width: 250,
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Convert your activities to points",
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                        onPressed: () {
                        
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ActivitiesScreen()));
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
