import 'package:flutter/material.dart';

class AuthenticationService {
  Future loginWithEmail(
      {@required String email, @required String password}) async {
    try {
      //var user = await signIn(email, password)

      //return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail(
      {@required String email,
      @required String password,
      @required String confirm}) async {
    try {
      //var user = await signIn(email, password)

      //return user != null;
    } catch (e) {
      return e.message;
    }
  }
}
