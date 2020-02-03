import 'package:flutter/material.dart';

class CreateRequest extends StatefulWidget {
  @override
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Create a Request'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Text('Create request page'),
    );
  }
}