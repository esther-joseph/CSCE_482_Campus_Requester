import 'package:flutter/material.dart';
import 'package:requester/locator.dart';
import 'package:requester/models/post.dart';
import 'package:requester/services/api_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/services/navigation_service.dart';

import 'base_model.dart';

class CreatePostViewModel extends BaseModel {
  final ApiService _apiService = locator<ApiService>();
  final DialogService _dialgService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future addPost({@required String title}) async {
    setBusy(true);

    var result = await _apiService.addPost(Post(title: title));
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
