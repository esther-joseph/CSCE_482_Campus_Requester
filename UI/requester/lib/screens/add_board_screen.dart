import 'package:flutter/material.dart';

class AddBoardScreen extends StatefulWidget {
  static const routeName = '/add-board';
  @override
  _AddBoardScreenState createState() => _AddBoardScreenState();
}

class _AddBoardScreenState extends State<AddBoardScreen> {
  final _requestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new request'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'What do you want to Request?'),
                      controller: _requestController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Request'),
            onPressed: () {},
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
