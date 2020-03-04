import 'package:flutter/material.dart';

class BaseAppbar {
  static getAppBar(String title) {
    return AppBar(
      backgroundColor: Color(0xff800000),
      title: Text(title),
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 15),
          child: IconButton(
            icon: Icon(Icons.person, color: Colors.white), 
            onPressed: null
          ),
        )
      ],
      leading: 
        IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white), 
        onPressed: null
        ),
    );
  }
}
