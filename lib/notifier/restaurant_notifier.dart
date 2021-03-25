import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:urban_eats/model/restaurant.dart';

class RestaurantNotifier with ChangeNotifier {
  List<Restaurant> _restaurantList = [];
  Restaurant _currentRestaurant;

  UnmodifiableListView<Restaurant> get restaurantList =>
      UnmodifiableListView(_restaurantList);

  Restaurant get currentRestaurant => _currentRestaurant;

  set restaurantList(List<Restaurant> restaurantList) {
    _restaurantList = restaurantList;
    notifyListeners();
  }

  set currentRestaurant(Restaurant restaurant) {
    _currentRestaurant = restaurant;
    notifyListeners();
  }
}
