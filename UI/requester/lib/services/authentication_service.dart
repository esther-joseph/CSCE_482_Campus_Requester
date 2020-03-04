import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      @required String userName}) async {
    try {
      // String token = await signUp(email, password, userName)
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
