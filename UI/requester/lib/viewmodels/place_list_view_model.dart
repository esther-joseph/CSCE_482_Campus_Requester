import 'package:flutter/material.dart';
import 'package:requester/services/web_service.dart';
import 'package:requester/viewmodels/place_view_model.dart';

class PlaceListViewModel extends ChangeNotifier{

  var places = List<PlaceViewModel>();

  Future<void> fetchPlacesByKeywordAndPosition(String keyword, double latitude, double longitude) async {
   
    final results = await WebService().fetchPlacesByKeywordAndPosition(keyword, latitude, longitude);
    this.places = results.map((place) => PlaceViewModel(place)).toList();
    notifyListeners();

  }

}