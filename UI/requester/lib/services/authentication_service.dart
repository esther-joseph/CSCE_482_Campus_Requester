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
      //var user = await signUp(email, password, confirm)
      //return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    //var user = await getCurrentUser();
    //return user != null;
    return false;
  }
}
