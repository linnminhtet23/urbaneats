import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:urban_eats/model/restaurant.dart';

class OnlyRestaurantNotifier with ChangeNotifier {
  List<Restaurant> _onlyrestaurantList = [];
  Restaurant _currentonlyRestaurant;

  UnmodifiableListView<Restaurant> get onlyrestaurantList =>
      UnmodifiableListView(_onlyrestaurantList);

  Restaurant get currentonlyRestaurant => _currentonlyRestaurant;

  set onlyrestaurantList(List<Restaurant> onlyrestaurantList) {
    _onlyrestaurantList = onlyrestaurantList;
    notifyListeners();
  }

  set currentonlyRestaurant(Restaurant restaurant) {
    _currentonlyRestaurant = restaurant;
    notifyListeners();
  }
}
