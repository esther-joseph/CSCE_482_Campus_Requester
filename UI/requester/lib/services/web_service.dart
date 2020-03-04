import 'dart:convert';

import 'package:requester/models/place.dart';
import 'package:requester/utils/url_helper.dart';
import 'package:http/http.dart' as http;

class WebService{

  Future<List<Place>> fetchPlacesByKeywordAndPosition(String keyword, double latitude, double longitude) async {

    final url = UrlHelper.urlForPlaceKeywordAndLocation(keyword, latitude, longitude);
  
    final response = await http.get(url);

    if (response.statusCode == 200){
        final jsonResponse = jsonDecode(response.body);
        final Iterable results = jsonResponse["results"];
        return results.map((place) => Place.fromJson(place)).toList();
    } else{
      throw Exception("Unable to perform request");
    }

  }
}