import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:requester/constants/route_names.dart';
import 'package:requester/locator.dart';
import 'package:requester/models/order.dart';
import 'package:requester/models/place.dart';
import 'package:requester/models/post.dart';
import 'package:requester/services/api_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/services/flutter_store_service.dart';
import 'package:requester/services/navigation_service.dart';
import 'package:requester/services/web_service.dart';
import 'package:requester/viewmodels/place_view_model.dart';

import 'base_model.dart';

class CreatePostViewModel extends BaseModel {
  final ApiService _apiService = locator<ApiService>();
  final DialogService _dialgService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final WebService _webService = locator<WebService>();
  final FlutterStoreService _flutterStoreSerice =
      locator<FlutterStoreService>();

  PlaceViewModel _selectedPosition;
  PlaceViewModel get selectedPosition => _selectedPosition;

  var places = List<PlaceViewModel>();
  Position _currentPosition;
  Position get currentPosition => _currentPosition;

  Future addPost({
    @required String item,
    @required String serviceFee,
    @required PlaceViewModel place,
    @required String deliveryTime,
    String price,
  }) async {
    setBusy(true);

    await _flutterStoreSerice.saveOrder(Order(
        await _flutterStoreSerice.getToken(),
        place.name,
        place.latitude,
        place.longitude,
        place.placeId,
        place.photoURL,
        item,
        serviceFee,
        price,
        deliveryTime));

    setBusy(false);

    await _dialgService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created');
    _navigationService.navigateTo(HomeViewRoute);
  }

  void onSelected(PlaceViewModel place) {
    _selectedPosition = place;
    print(_selectedPosition);
    notifyListeners();
  }

  Future<void> fetchPlacesByKeywordAndPosition(String keyword) async {
    setBusy(true);
    _currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final results = await _webService.fetchPlacesByKeywordAndPosition(
        keyword, _currentPosition.latitude, _currentPosition.longitude);
    print(results.map((place) => PlaceViewModel(place)).toList());
    this.places = results.map((place) => PlaceViewModel(place)).toList();
    setBusy(false);

    notifyListeners();
  }
}
