import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/notifier/restaurant_notifier.dart';
import 'package:urban_eats/screens/detailscreens/detail_screen.dart';
import 'package:urban_eats/screens/restaurantdetail.dart';
import 'package:urban_eats/style/theme.dart' as Style;

class RecentlyAdded extends StatefulWidget {
  @override
  _RecentlyAddedState createState() => _RecentlyAddedState();
}

class _RecentlyAddedState extends State<RecentlyAdded> {
  @override
  Future<void> initState() {
    // AuthNotifier authNotifier =
    //     Provider.of<AuthNotifier>(context, listen: false);
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context, listen: false);
    getRestaurant(restaurantNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context);
    Future<void> _refreshList() async {
      getRestaurant(restaurantNotifier);
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text(
              "RECENTLY ADDED",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                //color: Style.Colors.titleColor,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            height: 270.0,

            //width: 270.0,
            padding: EdgeInsets.only(left: 10.0),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: restaurantNotifier.restaurantList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        restaurantNotifier.currentRestaurant =
                            restaurantNotifier.restaurantList[index];
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return Detail();
                          }),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(10.0),
                            //elevation: 5.0,
                            child: Stack(
                              children: [
                                Container(
                                  width: 270.0,
                                  height: 200.0,
                                  decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    shape: BoxShape.rectangle,
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        restaurantNotifier.restaurantList[index]
                                                    .restaurantImage !=
                                                ""
                                            ? restaurantNotifier
                                                .restaurantList[index]
                                                .restaurantImage
                                            : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                      ),
                                    ),
                                  ),
                                  child: new Container(
                                    decoration: new BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [0.1, 0.5],
                                      colors: [
                                        Style.Colors.mainColor.withOpacity(0.9),
                                        Style.Colors.mainColor.withOpacity(0.0)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: 100,
                            child: Text(
                              restaurantNotifier
                                  .restaurantList[index].restaurantName,
                              maxLines: 2,
                              style: TextStyle(
                                  height: 1.4,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
