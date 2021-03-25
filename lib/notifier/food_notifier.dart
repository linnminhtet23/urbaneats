
import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:urban_eats/model/food.dart';

class FoodNotifier with ChangeNotifier{
  List<Food> _foodList=[];
  Food _currentFood;

  UnmodifiableListView <Food> get foodList=> UnmodifiableListView(_foodList);

  Food get currentFood=>_currentFood;

  set foodList(List<Food> foodList){
    _foodList= foodList;
    notifyListeners();
  }
  set currentFood(Food food){
    _currentFood= food;
    notifyListeners();
  }
}