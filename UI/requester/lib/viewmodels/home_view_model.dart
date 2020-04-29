library singleton;

import 'package:flutter/material.dart';
import 'package:requester/constants/route_names.dart';
import 'package:requester/locator.dart';
import 'package:requester/models/order.dart';
import 'package:requester/services/api_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/services/flutter_store_service.dart';
import 'package:requester/services/navigation_service.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:requester/viewmodels/place_view_model.dart';

import '../locator.dart';
import '../services/web_service.dart';

var Singleton = new Impl();

class Impl {
  Order order;
}

class HomeViewModel extends ChangeNotifier {
  final DialogService _dialgService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final WebService _webService = locator<WebService>();
  final FlutterStoreService _flutterStoreSerice =
      locator<FlutterStoreService>();

  final Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var places = List<PlaceViewModel>();

  GoogleMapController _controller;
  Position _currentPosition;
  Position get currentPosition => _currentPosition;

  List<Order> orders;

  var orderToAccept = Singleton;

  Future<void> onMarkerTapped(Order order) async {
    orderToAccept.order = order;

    _flutterStoreSerice.accepctOrder(order);
    _navigationService.navigateTo(AcceptOrderViewRoute);
  }

  Set<Marker> getPlaceMarkers() {
    if (orders != null) {
      for (final order in orders) {
        final MarkerId markerId = MarkerId(order.placeID);

        final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(order.latitude, order.longitude),
          infoWindow: InfoWindow(
              title: order.name, snippet: order.item + order.serviceFee),
          onTap: () {
            onMarkerTapped(order);
          },
        );

        markers[markerId] = marker;
        notifyListeners();

        //print(marker);
      }
    }

    return Set<Marker>.of(markers.values);
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    _currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 14)));
    orders = await _flutterStoreSerice.getOrders();
    notifyListeners();
  }

  // Future<void> fetchPlacesByKeywordAndPosition(
  //     String keyword, double latitude, double longitude) async {
  //   final results = await _webService.fetchPlacesByKeywordAndPosition(
  //       keyword, latitude, longitude);
  //   print(results.map((place) => PlaceViewModel(place)).toList());
  //   this.places = results.map((place) => PlaceViewModel(place)).toList();
  //   notifyListeners();
  // }

  void createButton() {
    _navigationService.navigateTo(CreatePostViewRoute);
  }
}
