import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/notifier/bar_notifier.dart';
import 'package:urban_eats/notifier/only_restaurant_notifier.dart';
import 'package:urban_eats/screens/detailscreens/bar_detail.dart';
import 'package:urban_eats/screens/detailscreens/detail_screen.dart';
import 'package:urban_eats/style/theme.dart' as Style;

class Bar extends StatefulWidget {
  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  Future<void> initState() {
    // AuthNotifier authNotifier =
    //     Provider.of<AuthNotifier>(context, listen: false);
    BarNotifier barNotifier = Provider.of<BarNotifier>(context, listen: false);
    getBar(barNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BarNotifier barNotifier = Provider.of<BarNotifier>(
      context,
    );
    getBar(barNotifier);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text(
              "RESTAURANTS",
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
            padding: EdgeInsets.only(left: 10.0),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: barNotifier.barList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        barNotifier.currentBar = barNotifier.barList[index];
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return BarDetail();
                          }),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 5.0,
                            child: Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    barNotifier.barList[index]
                                                .restaurantImage !=
                                            ""
                                        ? barNotifier
                                            .barList[index].restaurantImage
                                        : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: 100,
                            child: Text(
                              barNotifier.barList[index].restaurantName,
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
