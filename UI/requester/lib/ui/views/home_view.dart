import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '../../viewmodels/home_view_model.dart';
import '../../viewmodels/home_view_model.dart';
import '../../viewmodels/home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final menuController = TextEditingController();
  // final Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  // GoogleMapController _controller;
  // Position _currentPosition;

  // @override
  // void initState() {
  //   super.initState();
  // }

  // Set<Marker> _getPlaceMarkers(List<PlaceViewModel> places) {
  //   //TODO: add a read from our database and use those locations to add markers

  //   setState(() {
  //       markers.clear();
  //   });

  //   var i = 0;
  //   for(final place in places){
  //       String mar = i.toString();
  //       final MarkerId markerId = MarkerId(mar);
  //       //print(place.longitude);

  //       final Marker marker = Marker(
  //       markerId: markerId,
  //       position: LatLng(place.latitude, place.longitude),
  //       infoWindow: InfoWindow(
  //         title: place.name,
  //         snippet: '*'),
  //       );

  //       setState(() {
  //       markers[markerId] = marker;
  //       });
  //       i++;

  //       //print(marker);
  //   }

  //   for (final marker in markers.values.toSet()){
  //     print(marker);
  //   }

  //   return Set<Marker>.of(markers.values);
  // }

  // Future<void> _onMapCreated(GoogleMapController controller) async {
  //   _controller = controller;
  //   _currentPosition = await Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
  //       zoom: 14)));
  //   print(_currentPosition.latitude);
  //   print(_currentPosition.longitude);
  // }

  // void _selectLocation(PlaceViewModel vm) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => CreatePostView(place: vm),
  //       )
  //   );

  //   //final NavigationService _navigationService = locator<NavigationService>();
  //   //print(vm.name);
  //   //_navigationService.navigateTo(CreatePostViewRoute);
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
        viewModel: HomeViewModel(),
        builder: (context, model, child) => Scaffold(
              body: Stack(children: <Widget>[
                GoogleMap(
                  myLocationEnabled: true,
                  onMapCreated: model.onMapCreated,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(45.521563, -122.677433), zoom: 14),
                  markers: model.getPlaceMarkers(model.places),
                ),
                SafeArea(
                  child: TextField(
                    onSubmitted: (value) {
                      model.fetchPlacesByKeywordAndPosition(
                          value,
                          model.currentPosition.latitude,
                          model.currentPosition.longitude);
                    },
                    decoration: InputDecoration(
                        labelText: "Search here",
                        fillColor: Colors.white,
                        filled: true),
                  ),
                ),
                // Visibility(
                //   visible: vm.places.length > 0 ? true : false,
                //   child: SafeArea(
                //         child: Align(
                //         alignment: Alignment.bottomLeft,
                //         child: FlatButton(
                //         child: Text("Show List", style: TextStyle(color: Colors.white)),
                //         onPressed: () {
                //           showModalBottomSheet(
                //             context: context,
                //             builder: (context) => PlaceList(
                //               places: vm.places,
                //               onSelected: _selectLocation,
                //               ),
                //           );
                //         },
                //         color: Colors.grey,
                //       ),
                //     ),
                //   )
                // )
              ]),
            ));
  }
}

// SafeArea(
//               child: TextField(
//               onSubmitted: (value){
//                 vm.fetchPlacesByKeywordAndPosition(value, _currentPosition.latitude, _currentPosition.longitude);
//               },
//               decoration: InputDecoration(
//                 labelText: "Seach here",
//                 fillColor: Colors.white,
//                 filled: true
//               )
//             ),
//           )
