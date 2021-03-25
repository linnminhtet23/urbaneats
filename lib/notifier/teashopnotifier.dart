import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:urban_eats/model/restaurant.dart';

class TeashopNotifier with ChangeNotifier {
  List<Restaurant> _teashopList = [];
  Restaurant _currentTeashop;

  UnmodifiableListView<Restaurant> get teashopList =>
      UnmodifiableListView(_teashopList);

  Restaurant get currentTeashop => _currentTeashop;

  set teashopList(List<Restaurant> teashopList) {
    _teashopList = teashopList;
    notifyListeners();
  }

  set currentTeashop(Restaurant restaurant) {
    _currentTeashop = restaurant;
    notifyListeners();
  }
}
