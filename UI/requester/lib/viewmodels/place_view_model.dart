

import 'package:requester/models/place.dart';

class PlaceViewModel {
  
  Place _place;
  
  PlaceViewModel(Place place){
    this._place = place;
  }

  String get placeId{
    return this._place.placeID;
  }

  String get photURL{
    return this._place.photoURL;
  }

  String get name{
    return this._place.name;
  }

  double get latitude{
    return this._place.latitude;
  }
  
  double get longitude{
    return this._place.latitude;
  }

}