import 'package:flutter/material.dart';

import './Board.dart';

class Boards with ChangeNotifier {
  List<Board> _items = [];

  List<Board> get items {
    return [..._items];
  }
}
