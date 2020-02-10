import 'package:flutter/material.dart';

import './add_board_screen.dart';

class BoardListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddBoardScreen.routeName);
            },
          )
        ],
      ),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
