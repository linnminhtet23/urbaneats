import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_eats/screens/onboarding.dart';
import 'package:urban_eats/screens/signin.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getRunTimeCount(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(decoration: BoxDecoration(color: Colors.deepPurple)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Image.asset(
                        "assets/icon/pretzel.png",
                        height: 100,
                      ),
                      /*CircleAvatar(
                         backgroundColor: Colors.white,
                         radius: 50,
                       ),*/
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                    ])),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Colors.orange,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                                padding:
                                    EdgeInsets.fromLTRB(19.0, 4.0, 0.0, 0.0),
                                child: Text(
                                  'The creation of',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      //fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat'),
                                )),
                            Container(
                                padding:
                                    EdgeInsets.fromLTRB(19.0, 40.0, 0.0, 0.0),
                                child: Text(
                                  'Linn Min Htet',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }

  getRunTimeCount(BuildContext context) {
    var prefFuture = SharedPreferences.getInstance();
    prefFuture.then((pref) {
      var runTimeCount = pref.getInt('runtime') ?? 0;
      print(runTimeCount);
      if (runTimeCount > 0) {
        Timer(Duration(microseconds: 800), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) {
            return Signin();
          }));
        });
      } else {
        Timer(Duration(microseconds: 800), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) {
            return OBScreen();
          }));
        });
      }
      runTimeCount++;
      print("Runtime->$runTimeCount");
      pref.setInt("runtime", runTimeCount);
    });
  }
}
