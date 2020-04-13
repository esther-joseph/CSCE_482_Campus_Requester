import 'package:flutter/foundation.dart';
import 'package:requester/constants/route_names.dart';
import 'package:requester/locator.dart';
import 'package:requester/services/authentication_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/services/navigation_service.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final DialogService _dialogService = locator<DialogService>();

  final NavigationService _navigationService = locator<NavigationService>();

  Future signIn({
    @required String username,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
        username: username, password: password);

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(PostListViewRoute);
      } else {
        await _dialogService.showDialog(
            title: 'Sign In Failure',
            description: 'Sign In failure, Pleare try again');
      }
    } else {
      await _dialogService.showDialog(
          title: 'Sign In Failure', description: result);
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}
