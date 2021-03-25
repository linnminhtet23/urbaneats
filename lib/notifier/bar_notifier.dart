import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:urban_eats/model/restaurant.dart';

class BarNotifier with ChangeNotifier {
  List<Restaurant> _barList = [];
  Restaurant _currentBar;

  UnmodifiableListView<Restaurant> get barList =>
      UnmodifiableListView(_barList);

  Restaurant get currentBar => _currentBar;

  set barList(List<Restaurant> barList) {
    _barList = barList;
    notifyListeners();
  }

  set currentBar(Restaurant restaurant) {
    _currentBar = restaurant;
    notifyListeners();
  }
}
