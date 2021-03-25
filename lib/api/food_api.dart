import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:urban_eats/model/food.dart';
import 'package:urban_eats/model/restaurant.dart';
import 'package:urban_eats/model/user.dart';
import 'package:urban_eats/notifier/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urban_eats/notifier/bar_notifier.dart';
import 'package:urban_eats/notifier/food_notifier.dart';
import 'package:path/path.dart' as path;
import 'package:urban_eats/notifier/only_restaurant_notifier.dart';
import 'package:urban_eats/notifier/restaurant_notifier.dart';
import 'package:urban_eats/notifier/sushi_notifier.dart';
import 'package:urban_eats/notifier/teashopnotifier.dart';
import 'package:uuid/uuid.dart';

login(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));
//CollectionReference userRef = await Firestore.instance.collection('Users');
  if (authResult != null) {
    FirebaseUser firebaseUser = authResult.user;
    if (firebaseUser != null) {
      print("Login: $firebaseUser");
      authNotifier.setUser(firebaseUser);
      //getUser(authNotifier);
      //  DocumentReference documentReference = await userRef.add(user.toMap());
      // user.id = documentReference.documentID;
      // await documentReference.setData(user.toMap(), merge: true);
    }
  }
}

// getUser(AuthNotifier authNotifier) async {
//   QuerySnapshot snapshot =
//       await Firestore.instance.collection("Users").getDocuments();
//   List<User> _userList = [];
//   snapshot.documents.forEach((document) {
//     User user = User.fromMap(document.data);
//     _userList.add(user);
//   });
//   authNotifier.userList = _userList;
// }

signup(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: user.email, password: user.password)
      .catchError((error) => print(error.code));
  //CollectionReference userRef = await Firestore.instance.collection('Users');

  if (authResult != null) {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = user.displayName;
    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      await firebaseUser.updateProfile(updateInfo);
      await firebaseUser.reload();
      print("Signup: $firebaseUser");
      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      authNotifier.setUser(currentUser);
      // DocumentReference documentReference = await userRef.add(user.toMap());
      // user.id = documentReference.documentID;
      // await documentReference.setData(user.toMap(), merge: true);
    }
  }
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance
      .signOut()
      .catchError((error) => print(error.code));
  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

getFoods(FoodNotifier foodNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('Foods').getDocuments();

  List<Food> _foodList = [];

  snapshot.documents.forEach((document) {
    Food food = Food.fromMap(document.data);
    _foodList.add(food);
  });
  foodNotifier.foodList = _foodList;
}

getRestaurant(RestaurantNotifier restaurantNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Restaurant')
      .orderBy('createdAt', descending: true)
      .getDocuments();

  List<Restaurant> _restaurantList = [];

  snapshot.documents.forEach(
    (document) {
      Restaurant restaurant = Restaurant.fromMap(document.data);
      _restaurantList.add(restaurant);
    },
  );

  restaurantNotifier.restaurantList = _restaurantList;
}

getOnlyRestaurant(OnlyRestaurantNotifier onlyrestaurantNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Restaurant')
      .where("category", isEqualTo: "restaurant")
      // .orderBy('createdAt', descending: true)
      .getDocuments();

  List<Restaurant> _onlyrestaurantList = [];

  snapshot.documents.forEach((document) {
    Restaurant restaurant = Restaurant.fromMap(document.data);
    _onlyrestaurantList.add(restaurant);
  });

  onlyrestaurantNotifier.onlyrestaurantList = _onlyrestaurantList;
}

getBar(BarNotifier barNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Restaurant')
      .where("category", isEqualTo: "bar")
      // .orderBy('createdAt', descending: true)
      .getDocuments();

  List<Restaurant> _barList = [];

  snapshot.documents.forEach((document) {
    Restaurant restaurant = Restaurant.fromMap(document.data);
    _barList.add(restaurant);
  });

  barNotifier.barList = _barList;
}

getTeashop(TeashopNotifier teashopNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Restaurant')
      .where('category', isEqualTo: "teashop")
      //.orderBy('createdAt', descending: true)
      .getDocuments();

  List<Restaurant> _teashopList = [];

  snapshot.documents.forEach((document) {
    Restaurant restaurant = Restaurant.fromMap(document.data);
    _teashopList.add(restaurant);
  });

  teashopNotifier.teashopList = _teashopList;
}

uploadFoodAndImage(Food food, bool isUpdating, File localFile) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4(); // to give unique id
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("foods/$uuid$fileExtension");
    await firebaseStorageRef
        .putFile(localFile)
        .onComplete
        .catchError((onError) {
      print(onError);
      return false;
    });
    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadFood(food, isUpdating, imageUrl: url);
  } else {
    print('....skipping image upload');
    _uploadFood(food, isUpdating);
  }
}

_uploadFood(Food food, bool isUpdating, {String imageUrl}) async {
  CollectionReference foodRef = await Firestore.instance.collection('Foods');
  if (imageUrl != null) {
    food.image = imageUrl;
  }

  if (isUpdating) {
    food.updatedAt = Timestamp.now();
    await foodRef.document(food.id).updateData(food.toMap());
    print('updated food with id:${food.id}');
  } else {
    food.createdAt = Timestamp.now();

    DocumentReference documentReference = await foodRef.add(food.toMap());

    food.id = documentReference.documentID;
    print('uploaded food successfully: ${food.toString()}');

    await documentReference.setData(food.toMap(), merge: true);
  }
}

uploadRestaurantAndImage(Restaurant restaurant, File localFile) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4(); // to give unique id
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("restaurnats/$uuid$fileExtension");
    await firebaseStorageRef
        .putFile(localFile)
        .onComplete
        .catchError((onError) {
      print(onError);
      return false;
    });
    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadRestaurant(restaurant, imageUrl: url);
  } else {
    print('....skipping image upload');
    _uploadRestaurant(
      restaurant,
    );
  }
}

_uploadRestaurant(Restaurant restaurant, {String imageUrl}) async {
  CollectionReference foodRef =
      await Firestore.instance.collection('Restaurants');
  if (imageUrl != null) {
    restaurant.restaurantImage = imageUrl;
  }

  restaurant.createdAt = Timestamp.now();

  DocumentReference documentReference = await foodRef.add(restaurant.toMap());

  restaurant.id = documentReference.documentID;
  print('uploaded Restaurant successfully: ${restaurant.toString()}');

  await documentReference.setData(restaurant.toMap(), merge: true);
}
