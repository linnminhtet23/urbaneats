import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/notifier/restaurant_notifier.dart';

class Catrgory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context);
    return Container(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: restaurantNotifier.restaurantList.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.deepPurple,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        restaurantNotifier.restaurantList[index].category,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      //Text("$numberOfItems Kinds",)
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
