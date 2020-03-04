class Place{
  final String name;
  final double latitude;
  final double longitude;
  final String placeID;
  final String photoURL;

  Place({this.name, this.placeID, this.latitude, this.longitude, this.photoURL});

  factory Place.fromJson(Map<String,dynamic> json) {

    final location = json["geometry"]["location"];
    Iterable photos = json["photos"];

    return Place(
      placeID: json["place_id"],
      latitude: location["lat"],
      longitude: location["lng"],
      photoURL: photos.isEmpty == null ? "images/place-holder.png" : photos.first["photo_reference"].toString()
    );
  }
}