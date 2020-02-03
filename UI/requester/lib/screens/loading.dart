import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

    void getData() async {

      Response response = await get('https://godtiercapstoneasp.azurewebsites.net/Posts/ViewRecentPosts');
      List<dynamic> data = jsonDecode(response.body);
      print(data);

    //simulate network request for a requests


  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Loading screen')
      
    );
  }
}