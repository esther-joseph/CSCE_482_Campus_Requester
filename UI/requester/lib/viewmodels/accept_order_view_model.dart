import 'package:flutter/material.dart';
import 'package:requester/locator.dart';
import 'package:requester/models/place.dart';
import 'package:requester/models/post.dart';
import 'package:requester/services/api_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/services/navigation_service.dart';
import 'package:requester/viewmodels/place_view_model.dart';
import 'package:requester/models/order.dart';
import 'package:requester/constants/route_names.dart';

import 'base_model.dart';

class AcceptOrderViewModel extends BaseModel {
  final ApiService _apiService = locator<ApiService>();
  final DialogService _dialgService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  //TODO: change addPost to AcceptOrder
  //TODO: will push accepted order to user's profile
  Future acceptOrder({
    @required Order order,
  }) async {
    setBusy(true);
    print(order.name);
  //   await _flutterStoreSerice.saveOrder(Order(
  //       await _flutterStoreSerice.getToken(),
  //       place.name,
  //       place.latitude,
  //       place.longitude,
  //       place.placeId,
  //       place.photoURL,
  //       item,
  //       serviceFee,
  //       price));

    setBusy(false);

  //   await _dialgService.showDialog(
  //       title: 'Post successfully Added',
  //       description: 'Your post has been created');
  //   _navigationService.pop();
  // }
    _navigationService.navigateTo(DeliveryListViewRoute);
  }
}
