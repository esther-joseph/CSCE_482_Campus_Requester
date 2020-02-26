import 'package:flutter/material.dart';

class BottomNabar extends StatefulWidget {
  @override
  _BottomNabarState createState() => _BottomNabarState();
}

class _BottomNabarState extends State<BottomNabar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Request'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Delivery'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('MyAccount'),
          ),
        ],
        selectedItemColor: Colors.amber[800],
      ),
      body: Container(),
    );
  }
}
