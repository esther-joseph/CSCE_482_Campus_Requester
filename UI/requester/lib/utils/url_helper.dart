class UrlHelper{
  static String urlForPlaceKeywordAndLocation(String keyword, double latitude, double longitude){
    //print ("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&type=restaurant&keyword=$keyword&key=AIzaSyA4Bq64XhH_Mj2ZJTTnPgvZBeuk95J1GMs");
    return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&type=restaurant&keyword=$keyword&key=AIzaSyA4Bq64XhH_Mj2ZJTTnPgvZBeuk95J1GMs";
  }
}
