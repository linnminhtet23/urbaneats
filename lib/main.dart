import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/notifier/auth_notifier.dart';
import 'package:urban_eats/notifier/bar_notifier.dart';
import 'package:urban_eats/notifier/food_notifier.dart';
import 'package:urban_eats/notifier/only_restaurant_notifier.dart';
import 'package:urban_eats/notifier/restaurant_notifier.dart';
import 'package:urban_eats/notifier/sushi_notifier.dart';
import 'package:urban_eats/notifier/teashopnotifier.dart';
//import 'package:urban_eats/screens/chat.dart';
import 'package:urban_eats/screens/chatbot.dart';
import 'package:urban_eats/screens/discover.dart';
import 'package:urban_eats/screens/feed.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/screens/forgotpassword.dart';
import 'package:urban_eats/screens/info.dart';

import 'package:urban_eats/screens/map.dart';
import 'package:urban_eats/screens/restaurant_add_form.dart';
import 'package:urban_eats/screens/food_add_form.dart';
import 'package:urban_eats/screens/restaurantdetail.dart';
import 'package:urban_eats/screens/signin.dart';
import 'package:urban_eats/screens/navigationbar.dart';
import 'package:urban_eats/screens/signup.dart';
import 'package:urban_eats/screens/splashscreen.dart';
import 'package:urban_eats/screens/onboarding.dart';
import 'package:urban_eats/screens/signin.dart';

void main() {
  //StateWidget stateWidget = new StateWidget(child: new MyApp());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthNotifier()),
        // ChangeNotifierProvider(create: (context) => FoodNotifier()),
        ChangeNotifierProvider(create: (context) => RestaurantNotifier()),
        ChangeNotifierProvider(create: (context) => TeashopNotifier()),
        ChangeNotifierProvider(create: (context) => OnlyRestaurantNotifier()),
        ChangeNotifierProvider(create: (context) => BarNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //final themeManager =  Provider.of<ThemeManager>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Urban Eats',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.deepPurpleAccent,
      ),
      // themeMode: themeManager.themeMode,
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      /*home: Consumer<AuthNotifier>(
          builder: (context, notifier, child) {
            return notifier.user !=null ? Feed(): Login();
          },
        ),*/
      home: Consumer<AuthNotifier>(builder: (context, notifier, child) {
        return notifier.user != null ? Discover() : Signin();
      }),
    );
  }
}
