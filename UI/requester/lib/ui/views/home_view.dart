import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider_architecture/provider_architecture.dart';
import '../../viewmodels/home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
