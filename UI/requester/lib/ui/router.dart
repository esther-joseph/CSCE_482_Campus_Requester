import 'package:requester/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:requester/constants/route_names.dart';
import 'package:requester/ui/views/login_view.dart';
import 'package:requester/ui/views/signup_view.dart';
import 'package:requester/ui/views/create_post_view.dart';
import 'package:requester/ui/views/order_list.dart';
import 'package:requester/ui/views/delivery_list_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case OrderListViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: OrderListView(),
      );
    case DeliveryListViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DeliveryListView(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
