import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:urban_eats/model/user.dart';

class AuthNotifier with ChangeNotifier {
  FirebaseUser _user;
  User _currentUser;
  FirebaseUser get user => _user;
  User get currentUser => _currentUser;
  List<User> _userList = [];
  UnmodifiableListView<User> get userList => UnmodifiableListView(_userList);
  void setUser(FirebaseUser user) {
    _user = user;
    notifyListeners();
  }

  set userList(List<User> userList) {
    _userList = userList;
    notifyListeners();
  }

  set currentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}
