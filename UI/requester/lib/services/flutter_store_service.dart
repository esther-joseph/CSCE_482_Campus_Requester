import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:requester/models/order.dart';
import 'package:requester/models/user.dart';
import 'package:pref_dessert/pref_dessert.dart';

class FlutterStoreService {
  final storage = FlutterSecureStorage();
  final repo = new FuturePreferencesRepository<Order>(new JsonOrderDesSer());

  Future loginWithEmail(
      {@required String username, @required String password}) async {
    var url = 'https://pidgin.azurewebsites.net/CustomLogin/SignIn';

    try {
      var res = await http
          .post(url, body: {'username': username, 'password': password});

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      var user = User.fromData(json.decode(res.body));

      storage.write(key: 'jwt', value: user.jwtToken);
      // print(await storage.read(key: 'jwt'));

      return res.statusCode == 200;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail(
      {@required String email,
      @required String password,
      @required String userName}) async {
    var url = 'https://pidgin.azurewebsites.net/CustomLogin/Register';

    try {
      var res = await http.post(url,
          body: {'email': email, 'password': password, 'username': userName});
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      return res.statusCode == 200;

      // String token = await signUp(email, password, userName)
      //return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var jwt = await storage.read(key: "jwt");
    return jwt == null ? false : true;
  }

  Future<String> getToken() async {
    String token = await storage.read(key: "jwt");
    return token;
  }

  Future<void> saveOrder(Order order) async {
    repo.save(order);
  }

  Future<List<Order>> getOrders() {
    print(repo.findAll());
    return repo.findAll();
  }
}
