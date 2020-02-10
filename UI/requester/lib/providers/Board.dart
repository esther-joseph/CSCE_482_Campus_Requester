import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({this.address, this.latitude, this.longitude});
}

class Board {
  final String id;
  final String details;
  final String creationTime;
  final PlaceLocation location;
  bool isOpen;

  Board(
      {@required this.id,
      @required this.details,
      @required this.creationTime,
      this.location,
      @required this.isOpen});
}
