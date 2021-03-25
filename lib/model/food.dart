import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String id;
  String name;
  String category;
  String image;
  String restaurantName;
  String price;
  String discount;
  Timestamp createdAt; 
  Timestamp updatedAt ;

  Food();

  Food.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    category = data['category'];
    image = data['image'];
    restaurantName= data['restaurant_name'];
    price = data['price'];
    discount = data['discount'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'restaurant_name':restaurantName,
      'price': price,
      'discount':discount, 
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}
