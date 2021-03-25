import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/notifier/restaurant_notifier.dart';
import 'package:urban_eats/screens/detailscreens/detail_screen.dart';
import 'package:urban_eats/screens/restaurantdetail.dart';
import 'package:urban_eats/style/theme.dart' as Style;

class RecentAdded extends StatefulWidget {
  @override
  _RecentAddedState createState() => _RecentAddedState();
}

class _RecentAddedState extends State<RecentAdded>
    with SingleTickerProviderStateMixin {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context, listen: false);
    getRestaurant(restaurantNotifier);

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _animatedSlider());
  }

  void _animatedSlider() {
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context);
    Future.delayed(Duration(seconds: 2)).then((value) {
      int nextPage = pageController.page.round() + 1;
      if (nextPage == restaurantNotifier.restaurantList.length) {
        nextPage = 0;
      }
      pageController
          .animateToPage(nextPage,
              duration: Duration(seconds: 1), curve: Curves.linear)
          .then((value) => _animatedSlider());
    });
  }

  @override
  Widget build(BuildContext context) {
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context);
    Future<void> _refreshList() async {
      getRestaurant(restaurantNotifier);
    }

    if (restaurantNotifier.restaurantList.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "No More Restaurant",
                  style: TextStyle(color: Colors.black54),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
        height: 220.0,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          length: restaurantNotifier.restaurantList.take(5).length,
          indicatorSpace: 8.0,
          padding: const EdgeInsets.all(5.0),
          indicatorColor: Style.Colors.secondColor,
          shape: IndicatorShape.circle(size: 5.0),
          child: PageView.builder(
            pageSnapping: true,
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: restaurantNotifier.restaurantList.take(5).length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  restaurantNotifier.currentRestaurant =
                      restaurantNotifier.restaurantList[index];
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Detail()));
                },
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            restaurantNotifier.restaurantList[index]
                                        .restaurantImage !=
                                    ""
                                ? restaurantNotifier
                                    .restaurantList[index].restaurantImage
                                : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0.0,
                              0.7
                            ],
                            colors: [
                              Style.Colors.mainColor.withOpacity(1.0),
                              Style.Colors.mainColor.withOpacity(0.0)
                            ]),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
