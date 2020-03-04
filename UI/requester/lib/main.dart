import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requester/services/navigation_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/ui/views/create_post_view.dart';
import 'package:requester/ui/views/home_view.dart';
import 'package:requester/ui/views/login_view.dart';
import 'package:requester/ui/views/post_list_view.dart';
import 'package:requester/ui/views/splash_view.dart';
import 'package:requester/viewmodels/place_list_view_model.dart';
import 'managers/dialog_manager.dart';
import 'ui/router.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compound',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 9, 202, 172),
        backgroundColor: Color.fromARGB(255, 26, 27, 30),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
            ),
      ),
      home: ChangeNotifierProvider(
        create: (context) => PlaceListViewModel(),
        child: HomeView()
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
