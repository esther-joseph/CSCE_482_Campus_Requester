import 'package:requester/viewmodels/place_view_model.dart';

class Order {
  final int userId;
  final PlaceViewModel place;
  final String item;
  final String serviceFee;
  final String price;

  Order({this.userId, this.place, this.item, this.serviceFee, this.price});

  Order.fromData(Map<String, dynamic> data)
      : userId = data['userId'],
        place = data['place'],
        item = data['item'],
        serviceFee = data['serviceFee'],
        price = data['price'];

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'place': place,
      'item': item,
      'serviceFee': serviceFee,
      'price': price
    };
  }
}
