import 'package:flutter/material.dart';
import 'package:requester/locator.dart';
import 'package:requester/models/place.dart';
import 'package:requester/models/post.dart';
import 'package:requester/services/api_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/services/navigation_service.dart';
import 'package:requester/viewmodels/place_view_model.dart';

import 'base_model.dart';

class CreatePostViewModel extends BaseModel {
  final ApiService _apiService = locator<ApiService>();
  final DialogService _dialgService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future addPost({@required String item, @required String serviceFee, @required PlaceViewModel place}) async {
    setBusy(true);

    var result =
        await _apiService.addPost(Post(item: item, serviceFee: serviceFee, name: place.name, latitude: place.latitude, longitude: place.longitude, placeId: place.placeId));
    setBusy(false);

    if (result is String) {
      await _dialgService.showDialog(
          title: 'Could not create post', description: result);
    } else {
      await _dialgService.showDialog(
          title: 'Post successfully Added',
          description: 'Your post has been created');
    }
    _navigationService.pop();
  }
}
