import 'package:flutter/material.dart';
import 'package:requester/pages/home.dart';
import 'package:requester/pages/loading.dart';
import 'package:requester/pages/create_request.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/' : (context) => Loading(),
    '/home' : (context) => Home(),
    '/createRequest' : (context) => CreateRequest()
  },

));
