import 'package:flutter/material.dart';
import 'package:requester/ui/shared/app_colors.dart';

class BottomNabar extends StatefulWidget {
  @override
  _BottomNabarState createState() => _BottomNabarState();
}

class _BottomNabarState extends State<BottomNabar> {
  int _selectedIndex = 0;
static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('Order'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_run),
          title: Text('Delivery'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}


