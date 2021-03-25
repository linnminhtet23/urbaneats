import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/notifier/bar_notifier.dart';
import 'package:urban_eats/notifier/restaurant_notifier.dart';
import 'package:urban_eats/notifier/teashopnotifier.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:urban_eats/style/theme.dart' as Style;

class TeashopDetail extends StatefulWidget {
  @override
  _TeashopDetailState createState() => _TeashopDetailState();
}

class _TeashopDetailState extends State<TeashopDetail> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }

  GoogleMapController mapController;
  List<Marker> allMarkers = [];
  @override
  void initState() {
    TeashopNotifier teashopNotifier =
        Provider.of<TeashopNotifier>(context, listen: false);
    getTeashop(teashopNotifier);
    var lat = teashopNotifier.currentTeashop.location.latitude;
    var lng = teashopNotifier.currentTeashop.location.longitude;

    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: false,
        onTap: () {},
        position: LatLng(lat, lng)));
  }

  @override
  Widget build(BuildContext context) {
    TeashopNotifier teashopNotifier =
        Provider.of<TeashopNotifier>(context, listen: false);
    getTeashop(teashopNotifier);
    var lat = teashopNotifier.currentTeashop.location.latitude;
    var lng = teashopNotifier.currentTeashop.location.longitude;

    return Scaffold(
        body: SliverFab(
      floatingWidget: FloatingActionButton(
        onPressed: () {},
      ),
      slivers: [
        new SliverAppBar(
          expandedHeight: 250.0,
          pinned: true,
          flexibleSpace: new FlexibleSpaceBar(
            title: Text(
              teashopNotifier.currentTeashop.restaurantName.length > 40
                  ? teashopNotifier.currentTeashop.restaurantName
                          .substring(0, 37) +
                      "..."
                  : teashopNotifier.currentTeashop.restaurantName,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
            ),
            background: Stack(
              children: [
                Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        teashopNotifier.currentTeashop.restaurantImage != ""
                            ? teashopNotifier.currentTeashop.restaurantImage
                            : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                      ),
                    ),
                  ),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.black.withOpacity(0.5)),
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
        ),
        SliverPadding(
          padding: EdgeInsets.all(0.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "PHONES",
                    style: TextStyle(
                      //color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    customLaunch('tel: ${teashopNotifier.currentTeashop.phno}');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      teashopNotifier.currentTeashop.phno,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 2.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "ADDRESS",
                    style: TextStyle(
                      //color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    teashopNotifier.currentTeashop.address,
                    style: TextStyle(
                      fontSize: 15.0,
                      height: 1.5,
                    ),
                  ),
                ),
                Container(
                    // padding: EdgeInsets.only(
                    //     top: 8.0, left: 9.0, right: 9.0, bottom: 8.0),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(lat, lng),
                          zoom: 16.0,
                        ),
                        markers: Set.from(allMarkers),
                        zoomGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        scrollGesturesEnabled: false,
                      ),
                    )),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Text(
                          "SIMILAR ",
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)),
                        height: 270.0,
                        padding: EdgeInsets.only(left: 10.0),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: teashopNotifier.teashopList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, bottom: 10.0, right: 15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    teashopNotifier.currentTeashop =
                                        teashopNotifier.teashopList[index];
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return TeashopDetail();
                                      }),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Material(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                                teashopNotifier
                                                            .teashopList[index]
                                                            .restaurantImage !=
                                                        ""
                                                    ? teashopNotifier
                                                        .teashopList[index]
                                                        .restaurantImage
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
                                          teashopNotifier.teashopList[index]
                                              .restaurantName,
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
                ),
              ],
            ),
          ),
        ),
      ],
    )
        // Builder(
        //   builder: (context) {
        //     return SliverFab(slivers: [
        //       new SliverAppBar(
        //         expandedHeight: 250.0,
        //         pinned: true,
        //         flexibleSpace: new FlexibleSpaceBar(
        //           title:
        //               Text(restaurantNotifier.currentRestaurant.restaurantName),
        //         ),
        //       ),
        //     ], floatingWidget: null);
        //   },
        // ),
        );
  }
}
