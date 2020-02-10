import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requester/providers/auth.dart';

import './providers/Boards.dart';
import 'package:requester/screens/board_list_screen.dart';
import './screens/add_board_screen.dart';
import './screens/auth-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => new Auth(),
      child: ChangeNotifierProvider(
        create: (ctx) => new Boards(),
        child: MaterialApp(
          title: 'Requester',
          theme: ThemeData(
            primaryColor: Colors.indigo,
            accentColor: Colors.amber,
          ),
          home: AuthScreen(),
          routes: {
            AddBoardScreen.routeName: (ctx) => AddBoardScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
