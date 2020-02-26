import 'package:flutter/material.dart';

class RequstView extends StatefulWidget {
  @override
  _RequstViewState createState() => _RequstViewState();
}

class _RequstViewState extends State<RequstView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request'),
      ),
    );
  }
}