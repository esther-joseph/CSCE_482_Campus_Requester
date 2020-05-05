import 'package:flutter/material.dart';
import 'package:requester/viewmodels/place_view_model.dart';
import 'package:requester/viewmodels/create_post_view_model.dart';
import 'package:requester/utils/url_helper.dart';

class PlaceList extends StatelessWidget {
  final List<PlaceViewModel> places;

  Function(PlaceViewModel) onSelected;

  PlaceList({this.places, this.onSelected});

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.places.length,
      itemBuilder: (context, index) {
        final place = this.places[index];

        //print(place);
        //print(place.name);

        return ListTile(
            onTap: () {
              //go to create post
              this.onSelected(place);
            },
            leading: Container(
                width: 100,
                height: 100,
                child: Image.network(
                    UrlHelper.urlForReferenceImage(place.photoURL),
                    fit: BoxFit.cover)),
            title: Text(place.name));
      },
    );
  }
}
