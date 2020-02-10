import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/Boards.dart';
import 'package:requester/screens/board_list_screen.dart';
import './screens/add_board_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => new Boards(),
      child: MaterialApp(
        title: 'Requester',
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: BoardListScreen(),
        routes: {
          AddBoardScreen.routeName: (ctx) => AddBoardScreen(),
        },
      ),
    );
  }
}
