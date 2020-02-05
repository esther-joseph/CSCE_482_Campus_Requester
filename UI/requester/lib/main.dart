import 'package:flutter/material.dart';
import 'package:requester/screens/home.dart';
import 'package:requester/screens/loading.dart';
import 'package:requester/screens/create_request.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/' : (context) => Loading(),
    '/home' : (context) => Home(),
    '/createRequest' : (context) => CreateRequest()
  },

));
