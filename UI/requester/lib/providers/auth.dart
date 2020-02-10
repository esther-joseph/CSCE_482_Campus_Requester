import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    final url = '';

    /*TODO
    Have to add url
    */
    final response = await http.post(url,
        body: jsonEncode({email: email, password: password}));
  }
}

//
