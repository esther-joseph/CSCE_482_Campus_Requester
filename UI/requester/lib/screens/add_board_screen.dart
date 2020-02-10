import 'package:flutter/material.dart';

class AddBoardScreen extends StatefulWidget {
  static const routeName = '/add-board';
  @override
  _AddBoardScreenState createState() => _AddBoardScreenState();
}

class _AddBoardScreenState extends State<AddBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new request'),
      ),
      body: Column(
        children: <Widget>[
          Text('User Inputss..'),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Request'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
