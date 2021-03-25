import 'package:firebase_auth/firebase_auth.dart';
import 'package:urban_eats/model/settings.dart';
import 'package:urban_eats/model/usercopy.dart';


class StateModel {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  User user;
  Settings settings;

  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.user,
    this.settings,
  });
}
