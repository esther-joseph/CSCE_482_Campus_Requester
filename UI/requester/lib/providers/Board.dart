import 'package:flutter/foundation.dart';

class Board {
  final String id;
  final String details;
  final String creationTime;
  bool isOpen;

  Board(
      {@required this.id,
      @required this.details,
      @required this.creationTime,
      @required this.isOpen});
}
