import 'package:pref_dessert/pref_dessert.dart';
import 'dart:convert';

class Order {
  final String userId;
  final String name;
  final double latitude;
  final double longitude;
  final String placeID;
  final String photoURL;
  final String item;
  final String serviceFee;
  final String price;
  final String deliveryTime;

  Order(this.userId, this.name, this.latitude, this.longitude, this.placeID,
      this.photoURL, this.item, this.serviceFee, this.price, this.deliveryTime);
}

class JsonOrderDesSer extends DesSer<Order> {
  @override
  Order deserialize(String s) {
    var map = json.decode(s);
    return Order(
        map['userId'] as String,
        map['name'] as String,
        map['latitude'] as double,
        map['longitude'] as double,
        map['placeID'] as String,
        map['photoURL'] as String,
        map['item'] as String,
        map['serviceFee'] as String,
        map['price'] as String,
        map['deliveryTime'] as String);
  }

  @override
  String serialize(Order t) {
    var map = {
      "userId": t.userId,
      "name": t.name,
      "latitude": t.latitude,
      "longitude": t.longitude,
      "placeID": t.placeID,
      "photoURL": t.photoURL,
      "item": t.item,
      "serviceFee": t.serviceFee,
      "price": t.price,
      "deliveryTime": t.deliveryTime
    };
    return json.encode(map);
  }

  @override
  // TODO: implement key
  String get key => "Order";
}
