import 'package:flutter/material.dart';
import 'package:requester/ui/shared/app_colors.dart';
import 'package:requester/ui/views/home_view.dart';
import 'package:requester/ui/views/delivery_list_view.dart';
import 'package:requester/services/navigation_service.dart';
import 'package:requester/locator.dart';
import 'package:requester/constants/route_names.dart';
import 'package:requester/viewmodels/place_list_view_model.dart';
import 'package:requester/managers/dialog_manager.dart';
import 'package:requester/ui/router.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:provider/provider.dart';

class BottomNabar extends StatefulWidget {
  @override
  _BottomNabarState createState() => _BottomNabarState();
}

class _BottomNabarState extends State<BottomNabar> with ChangeNotifier {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
        break;
      case 1:
        final NavigationService _navigationService =
            locator<NavigationService>();
        _navigationService.navigateTo(OrderListViewRoute);
        break;
      case 2:
        final NavigationService _navigationService =
            locator<NavigationService>();
        _navigationService.navigateTo(DeliveryListViewRoute);
        break;
    }
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
      onTap: _onItemTapped,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
          create: (context) => PlaceListViewModel(), child: HomeView()),
//      home: SplashView(),
      onGenerateRoute: generateRoute,
    );
  }
}
