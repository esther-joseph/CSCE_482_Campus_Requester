import 'package:flutter/material.dart';
import 'package:requester/constants/route_names.dart';
import 'package:requester/locator.dart';
import 'package:requester/services/authentication_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/services/navigation_service.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final DialogService _dialogService = locator<DialogService>();

  final NavigationService _navigationService = locator<NavigationService>();

  Future signUp(
      {@required String email,
      @required String password,
      @required String userName}) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
        email: email, password: password, userName: userName);

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(LoginViewRoute);
      } else {
        await _dialogService.showDialog(
            title: 'Sign Up Failure',
            description: 'Sign up failure, Pleare try again');
      }
    } else {
      await _dialogService.showDialog(
          title: 'Sign Up Failure', description: result);
    }
  }
}
