import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Map data;
  List userData;

  @override
  void initState() {
    super.initState();
    getData();
  }
  Future getData() async {
    // var response = await http.get(
    http.Response response = await http.get('https://godtiercapstoneasp.azurewebsites.net/Posts/ViewRecentPosts');

    print(response.body);

    setState(() {
      userData = json.decode(response.body);
    });
  }
  // Future<String> getData() async {
  //   http.Response response = await http.get();
  //   data = json.decode(response.body);
  //   setState(() {
  //     userData = data["data"];
  //   });
  //     // List<dynamic> data = jsonDecode(response.body);
  //     // print(data);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campus Requester'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0: userData.length,
        itemBuilder: (BuildContext context, int index){
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text(userData[index]['details']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/createRequest');
          },
          child: Text('New'),
          backgroundColor: Colors.blueGrey[600],
          ),
    );
  }
}