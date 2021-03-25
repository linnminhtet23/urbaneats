import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/notifier/auth_notifier.dart';
import 'package:urban_eats/notifier/food_notifier.dart';
import 'package:urban_eats/notifier/restaurant_notifier.dart';
import 'package:urban_eats/screens/chatbot.dart';
import 'package:urban_eats/screens/detail.dart';
import 'package:urban_eats/screens/food_add_form.dart';
import 'package:urban_eats/screens/profile.dart';
import 'package:urban_eats/screens/restaurantdetail.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  void initState() {
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context, listen: false);
    getRestaurant(restaurantNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context);
    print("building feed");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Feed",
          style: TextStyle(),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () => signout(authNotifier),
              child: Text(
                "Logout",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ))
        ],
      ),
      body: ListView.separated(
        itemCount: restaurantNotifier.restaurantList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Image.network(
                restaurantNotifier.restaurantList[index].restaurantImage != ""
                    ? restaurantNotifier.restaurantList[index].restaurantImage
                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                width: 120,
                fit: BoxFit.fitWidth,
              ),
              title:
                  Text(restaurantNotifier.restaurantList[index].restaurantName),
              subtitle: Text(restaurantNotifier.restaurantList[index].phno),
              onTap: () {
                restaurantNotifier.currentRestaurant =
                    restaurantNotifier.restaurantList[index];
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return RestaurantDetail();
                  }),
                );
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          restaurantNotifier.currentRestaurant = null;
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return FoodAddForm(
                isUpdating: false,
              );
            }),
          );
        },
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
      ),
    );
  }
}
