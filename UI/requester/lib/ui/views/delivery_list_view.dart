
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:requester/ui/widgets/now_delivery_list.dart';
import 'package:requester/ui/widgets/past_delivery_list.dart';

import '../widgets/bottom_navbar.dart';

class DeliveryListView extends StatefulWidget {
  @override
  _DeliveryListViewState createState() => _DeliveryListViewState();
}

class _DeliveryListViewState extends State<DeliveryListView> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this, initialIndex:0);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle().copyWith(statusBarColor: Colors.green));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff800000),
        title: Text('Delivery List'),
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
        bottom: TabBar(
          indicator: UnderlineTabIndicator(
            insets: EdgeInsets.symmetric(horizontal:16)
          ),
          controller: controller,
          tabs: <Widget>[
            Tab(text: 'Now'),
            Tab(text: 'Past'),
          ],
        )
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          NowDeliveryList(),
          PastDeliveryList(),
        ]),
        bottomNavigationBar: BottomNabar(),
    );
  }
}
