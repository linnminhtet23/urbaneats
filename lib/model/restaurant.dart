import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  String id;
  String restaurantName;
  String address;
  String restaurantImage;
  String time;
  String category;
  List hours;
  GeoPoint location;
  String phno;
  List views;
  Timestamp createdAt;
  Timestamp updatedAt;

  Restaurant();
  Restaurant.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    restaurantName = data['restaurantname'];
    restaurantImage = data['image'];
    location = data['location'];
    hours = data['hours'];
    category = data['category'];
    phno = data['phno'];
    address = data['address'];
    views = data['images'];
    createdAt = data['createdAt'];
    // updatedAt = data['updatedAt'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurntname': restaurantName,
      'address': address,
      'image': restaurantImage,
      'time': time,
      'location': location,
      'phno': phno,
      'images': views,
      'createdAt': createdAt,
      // 'updatedAt': updatedAt
    };
  }
}
