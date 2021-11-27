import 'package:http/http.dart' as http;
import 'dart:convert';
const GOOGLE_API_KEY='AIzaSyC9xl8ohN3gbTgC5pQoCFPrbceDfCiJmto';

class LocationHelper{
  static String generateLocationPreviewImage({double? lattitude, double? longitude}){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$lattitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$lattitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async{
    final url= Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');
    final response= await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}