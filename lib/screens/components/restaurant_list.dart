import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/notifier/restaurant_notifier.dart';
import 'package:urban_eats/screens/restaurantdetail.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(BuildContext context) {
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context);
    Future<void> _refreshList() async {
      getRestaurant(restaurantNotifier);
    }

    return ListView.builder(
        itemCount: restaurantNotifier.restaurantList.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              index.bitLength == 0
                  ? Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            bottom: 36 + 20.0,
                          ),
                          height: MediaQuery.of(context).size.height * 0.2 - 27,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(36),
                              bottomRight: Radius.circular(36),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Discover',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Container(),
              GestureDetector(
                onTap: () {
                  restaurantNotifier.currentRestaurant =
                      restaurantNotifier.restaurantList[index];
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return RestaurantDetail();
                    }),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                    //padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Material(
                      //borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                      elevation: 3.0,
                      child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0)),
                              width: 210.0,
                              height: 210.0,
                              child: Image.network(
                                restaurantNotifier.restaurantList[index]
                                            .restaurantImage !=
                                        ""
                                    ? restaurantNotifier
                                        .restaurantList[index].restaurantImage
                                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                width: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              restaurantNotifier
                                  .restaurantList[index].restaurantName,
                              style: TextStyle(
                                  fontSize: 16.0, fontFamily: "Rubik"),
                            ),
                            // SizedBox(height: 10.0),
                            // Text(restaurantNotifier
                            //     .restaurantList[index].phno)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
