import 'package:flutter/material.dart';
import 'package:requester/services/navigation_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/ui/views/create_post_view.dart';
import 'package:requester/ui/views/delivery_list_view.dart';
import 'package:requester/ui/views/home_view.dart';
import 'package:requester/ui/views/login_view.dart';
import 'package:requester/ui/views/order_list.dart';
import 'package:requester/ui/views/post_list_view.dart';
import 'package:requester/ui/views/signup_view.dart';
import 'package:requester/ui/views/splash_view.dart';
import 'package:requester/ui/widgets/now_order_list.dart';
import 'package:requester/ui/widgets/past_order_list.dart';
import 'package:requester/viewmodels/post_list_view_model.dart';
import 'managers/dialog_manager.dart';
import 'ui/router.dart';
import 'locator.dart';
import 'ui/views/post_list_view.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compound',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Open Sans',
          bodyColor: Colors.black,
          displayColor: Colors.black)),
      
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      // theme: ThemeData(
      //   primaryColor: Color.fromARGB(255, 9, 202, 172),
      //   backgroundColor: Color.fromARGB(255, 26, 27, 30),
      //   textTheme: Theme.of(context).textTheme.apply(
      //         fontFamily: 'Open Sans',
      //   ),
      // ),
      home: OrderListView(),
      onGenerateRoute: generateRoute,
    );
  }
}
