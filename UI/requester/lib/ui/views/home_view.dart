import 'package:flutter/material.dart';
import 'package:requester/ui/widgets/bottom_navbar.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar Demo',
      home: BottomNabar(),
    );
  }
}