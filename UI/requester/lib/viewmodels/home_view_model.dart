import 'package:flutter/material.dart';
import 'package:requester/locator.dart';
import 'package:requester/services/api_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/services/navigation_service.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:requester/viewmodels/place_view_model.dart';

import '../locator.dart';
import '../services/web_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = locator<ApiService>();
  final DialogService _dialgService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final WebService _webService = locator<WebService>();

  final menuController = TextEditingController();
  final Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var places = List<PlaceViewModel>();

  GoogleMapController _controller;
  Position _currentPosition;

  Position get currentPosition => _currentPosition;

  Set<Marker> getPlaceMarkers(List<PlaceViewModel> places) {
    markers.clear();
    var i = 0;
    for (final place in places) {
      String mar = i.toString();
      final MarkerId markerId = MarkerId(mar);
      //print(place.longitude);

      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(place.latitude, place.longitude),
        infoWindow: InfoWindow(title: place.name, snippet: '*'),
      );

      markers[markerId] = marker;
      notifyListeners();
      i++;

      //print(marker);
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
    notifyListeners();

    print(_currentPosition.latitude);
    print(_currentPosition.longitude);
  }

  Future<void> fetchPlacesByKeywordAndPosition(
      String keyword, double latitude, double longitude) async {
    final results = await _webService.fetchPlacesByKeywordAndPosition(
        keyword, latitude, longitude);
    print(results.map((place) => PlaceViewModel(place)).toList());
    this.places = results.map((place) => PlaceViewModel(place)).toList();
    notifyListeners();
  }

  void selectLocation() {}
}
