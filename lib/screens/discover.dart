import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/model/restaurant.dart';
import 'package:urban_eats/model/state.dart';
import 'package:urban_eats/notifier/auth_notifier.dart';
import 'package:urban_eats/notifier/food_notifier.dart';
import 'package:urban_eats/notifier/restaurant_notifier.dart';
//import 'package:urban_eats/screens/chat.dart';
import 'package:urban_eats/screens/chatbot.dart';
import 'package:urban_eats/screens/components/bar_list.dart';
import 'package:urban_eats/screens/components/header.dart';
import 'package:urban_eats/screens/components/only_restaurant.dart';

import 'package:urban_eats/screens/components/recentadded.dart';
import 'package:urban_eats/screens/components/recently_added.dart';
import 'package:urban_eats/screens/components/restaurant_list.dart';
import 'package:urban_eats/screens/components/teashop.dart';
import 'package:urban_eats/screens/info.dart';
import 'package:urban_eats/screens/modechanger.dart';
import 'package:urban_eats/screens/signin.dart';
import 'package:urban_eats/screens/map.dart';
import 'package:urban_eats/screens/restaurantdetail.dart';
import 'package:urban_eats/style/theme.dart' as Style;
// import 'package:urban_eats/util/auth.dart';

// import 'package:urban_eats/util/state_widget.dart';
// import 'package:urban_eats/util/ui/widgets/loading.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  StateModel appState;
  bool _loadingVisible = false;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  // @override
  // Future<void> initState() {
  //   // AuthNotifier authNotifier =
  //   //     Provider.of<AuthNotifier>(context, listen: false);
  //   RestaurantNotifier restaurantNotifier =
  //       Provider.of<RestaurantNotifier>(context, listen: false);
  //   getRestaurant(restaurantNotifier);
  //   getTeashop(restaurantNotifier);

  //   super.initState();
  // }

  // Future<void> _changeLoadingVisible() async {
  //   setState(() {
  //     _loadingVisible = !_loadingVisible;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context);
    Future<void> _refreshList() async {
      getRestaurant(restaurantNotifier);
    }

    return Scaffold(
      //backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        centerTitle: true,
        //leading: InkWell(onTap:(){},child: Icon(Icons.menu)),
        title: Text(
          "Discover",
          overflow: TextOverflow.fade,
          style: TextStyle(
            //fontFamily: "Rubik",
            fontSize: 20,
          ),
        ),
        elevation: 0.0,
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text(authNotifier.user.displayName != null
                  ? authNotifier.user.displayName
                  : ""),
              accountEmail: Text(authNotifier.user.email != null
                  ? authNotifier.user.email
                  : ""),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Text(authNotifier.user.displayName[0]),
                ),
              ),
            ),
            new ListTile(
                leading: new Icon(Icons.adb),
                title: Text("Talk With Chatbot"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Chatbot()));
                }),
            Divider(
              thickness: 2.0,
            ),
            new ListTile(
              leading: new Icon(Icons.settings),
              title: Text("Change Theme"),
              onTap: () {
                //  Navigator.of(context).pop();
                //  Navigator.of(context).push(MaterialPageRoute(
                //      builder: (context) => SettingScreen(true)));
              },
            ),
            Divider(
              thickness: 2.0,
            ),
            new ListTile(
                leading: new Icon(Icons.info),
                title: Text("Developer's info"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Info()));
                }),
            Divider(
              thickness: 2.0,
            ),
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 50),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () {
                  signout(authNotifier);
                },
                padding: EdgeInsets.all(16),
                color: Theme.of(context).primaryColor,
                child: Text('SIGN OUT', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          //Header(),
          RecentAdded(),
          RecentlyAdded(),
          OnlyRestaurant(),
          TeaShop(),
          Bar(),
        ],
      ),
    );
    //}
  }
}
