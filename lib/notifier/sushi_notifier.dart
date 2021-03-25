import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:urban_eats/model/restaurant.dart';

class SushiNotifier with ChangeNotifier {
  List<Restaurant> _sushiList = [];
  Restaurant _currentsushi;

  UnmodifiableListView<Restaurant> get sushiList =>
      UnmodifiableListView(_sushiList);

  Restaurant get currentSushi => _currentsushi;

  set sushiList(List<Restaurant> sushiList) {
    _sushiList = sushiList;
    notifyListeners();
  }

  set currentSushi(Restaurant restaurant) {
    _currentsushi = restaurant;
    notifyListeners();
  }
}
