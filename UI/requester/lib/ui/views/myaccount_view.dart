import 'package:flutter/material.dart';
import 'package:requester/ui/widgets/base_appbar.dart';

class MyaccountView extends StatefulWidget {
  @override
  _MyaccountViewState createState() => _MyaccountViewState();
}

class _MyaccountViewState extends State<MyaccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar.getAppBar('My Account'),

    );
  }
}