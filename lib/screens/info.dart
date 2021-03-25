import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Info extends StatelessWidget {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Developer's info"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(36.0),
            topRight: Radius.circular(36.0)
          )
        ),
        child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 80.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage(
                        "assets/images/ME.jpg",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text("Developed by Linn Min Htet",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Text("Used programming language:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    SizedBox(
                      width: 5.0,
                    ),
                    Center(
                        child: InkWell(
                      onTap: () {
                        customLaunch(
                            "https://flutter.dev/?gclid=Cj0KCQjwvvj5BRDkARIsAGD9vlLH1EagTDl1VsNSFKyonmxfKm60i4l8m1ZiEfAC7TnMuDgtAHpnO1EaAqDaEALw_wcB&gclsrc=aw.ds");
                      },
                      child: Text("Flutter",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue,
                              decoration: TextDecoration.underline)),
                    )),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: Image.asset("assets/icon/facebook.png"),
                        onPressed: () {
                          customLaunch("https://www.facebook.com/linnmin.htet23");
                        }),
                    SizedBox(
                      width: 5.0,
                    ),
                    IconButton(
                        icon: Image.asset("assets/icon/instagram.png"),
                        onPressed: () {
                          customLaunch("https://www.instagram.com/jonathan231996/");
                        }),
                    SizedBox(
                      width: 5.0,
                    ),
                    
                    IconButton(
                        icon: Image.asset("assets/icon/gmail.png"),
                        onPressed: () {
                          customLaunch("mailto:linnminhtet23@gmail.com");
                        }),
                    SizedBox(
                      width: 5.0,
                    ),
                    IconButton(
                        icon: Image.asset("assets/icon/contact.png"),
                        onPressed: () {
                          customLaunch("tel: 09962011716");
                        }),
                    SizedBox(
                      width: 5.0,
                    ),
                    
                  ],

                ),
                Divider(thickness: 4.4,),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                    child: Text("© Copyright 2020 | All rights reserved ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16
                            ))),
                
              ],
            ),
      )
  
    );
  }
}
