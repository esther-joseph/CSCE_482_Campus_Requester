import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

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
