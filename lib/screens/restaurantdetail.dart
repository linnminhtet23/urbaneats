import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/notifier/restaurant_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetail extends StatefulWidget {
  @override
  _RestaurantDetailState createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
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
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context, listen: false);
    getRestaurant(restaurantNotifier);
    var lat = restaurantNotifier.currentRestaurant.location.latitude;
    var lng = restaurantNotifier.currentRestaurant.location.longitude;

    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: false,
        onTap: () {},
        position: LatLng(lat, lng)));
  }

  @override
  Widget build(BuildContext context) {
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context);
    var Lat = restaurantNotifier.currentRestaurant.location.latitude;
    var Lng = restaurantNotifier.currentRestaurant.location.longitude;

    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 5.0,
              iconTheme:
                  IconThemeData(color: Colors.deepPurpleAccent, opacity: 100.0),
              //title: Text(restaurantNotifier.currentRestaurant.restaurantName),
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                    restaurantNotifier.currentRestaurant.restaurantImage != ""
                        ? restaurantNotifier.currentRestaurant.restaurantImage
                        : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  restaurantNotifier.currentRestaurant.restaurantName,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Text("Contact",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        customLaunch(
                            'tel: ${restaurantNotifier.currentRestaurant.phno}');
                      },
                      child: Text(
                        restaurantNotifier.currentRestaurant.phno,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Text("Address",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(
                      width: 9,
                    ),
                    Expanded(
                      child: Text(
                        restaurantNotifier.currentRestaurant.address,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                  title: Text(
                    "Hours",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  children: restaurantNotifier.currentRestaurant.hours
                      .map((hours) => Column(
                            children: <Widget>[
                              Text(
                                hours,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 10.0)
                            ],
                          ))
                      .toList()),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Row(
              //     children: <Widget>[
              //       Text("Hours:",
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, fontSize: 25)),
              //       SizedBox(
              //         width: 15,
              //       ),

              //       // onTap: () {
              //       //   customLaunch(
              //       //       'tel: ${restaurantNotifier.currentRestaurant.phno}');
              //       // },
              //       Text(
              //         restaurantNotifier.currentRestaurant.hours,
              //         style: TextStyle(fontSize: 20, color: Colors.blue),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                  padding: EdgeInsets.only(
                      top: 8.0, left: 9.0, right: 9.0, bottom: 8.0),
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(Lat, Lng),
                        zoom: 16.0,
                      ),
                      markers: Set.from(allMarkers),
                      zoomGesturesEnabled: false,
                      zoomControlsEnabled: false,
                      scrollGesturesEnabled: false,
                    ),
                  )),
              // ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: restaurantNotifier.currentRestaurant.views.length,
              //     itemBuilder: (context, index) {
              //       Image.network(
              //         restaurantNotifier.currentRestaurant.views
              // //         .map((views) => Image.network(
              // //               views,
              //               fit: BoxFit.cover,
              //             ))
              //          .toList()
              //         ) ;
              //     }),
              GridView.count(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  children: restaurantNotifier.currentRestaurant.views
                      .map((views) => Image.network(
                            views != ""
                                ? views
                                : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                            fit: BoxFit.cover,
                          ))
                      .toList()),
            ]))
          ],
        ),
      ),
    );
  }
}
