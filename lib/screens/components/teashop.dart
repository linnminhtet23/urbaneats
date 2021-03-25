import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/notifier/restaurant_notifier.dart';
import 'package:urban_eats/notifier/teashopnotifier.dart';
import 'package:urban_eats/screens/detailscreens/detail_screen.dart';
import 'package:urban_eats/screens/detailscreens/teashop_detil.dart';
import 'package:urban_eats/screens/restaurantdetail.dart';
import 'package:urban_eats/style/theme.dart' as Style;

class TeaShop extends StatefulWidget {
  @override
  _TeaShopState createState() => _TeaShopState();
}

class _TeaShopState extends State<TeaShop> {
  @override
  Future<void> initState() {
    // AuthNotifier authNotifier =
    //     Provider.of<AuthNotifier>(context, listen: false);
    TeashopNotifier teashopNotifier =
        Provider.of<TeashopNotifier>(context, listen: false);
    getTeashop(teashopNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TeashopNotifier teashopNotifier = Provider.of<TeashopNotifier>(context);
    Future<void> _refreshList() async {
      getTeashop(teashopNotifier);
    }

    return Card(
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text(
              "TEASHOP",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            height: 270.0,
            padding: EdgeInsets.only(left: 10.0),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: teashopNotifier.teashopList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        teashopNotifier.currentTeashop =
                            teashopNotifier.teashopList[index];
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return TeashopDetail();
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
                                    teashopNotifier.teashopList[index]
                                                .restaurantImage !=
                                            ""
                                        ? teashopNotifier
                                            .teashopList[index].restaurantImage
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
                              teashopNotifier.teashopList[index].restaurantName,
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
