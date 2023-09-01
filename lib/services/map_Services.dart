import 'dart:convert';

//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart'; 
import 'package:http/http.dart' as http;

class MapServices{

  static const String apikey= 'AIzaSyBWCuOnfehA4-Cp3CcrSSl0gGZ-J2Ssfbs';
  static Future<List<LatLng>> getRouteCoordinates(LatLng start, LatLng end) async {
    String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$apikey';

    final response= await  http.get(Uri.parse(url)); 

    if (response.statusCode == 200){
      final decode= jsonDecode(response.body);
      List<LatLng> coordinates = _decodeRouteCoordinates(decode);
      return coordinates;
    }else{
      throw Exception('Failed route coordinates');
    }
  }

  static List<LatLng> _decodeRouteCoordinates(dynamic decoded){
      List<LatLng> coordinates= [];
      List<dynamic> pasos=  decoded['routes'][0]['legs']['pasos'];
      pasos.forEach((paso) {
        double lat= paso['start_location']['lat'];
        double lng= paso['start_location']['lng'];

        double endlat = paso['end_location']['lat'];
        double endlng= paso['end_location']['lng'];
        coordinates.add(LatLng(endlat, endlng));
      });
      return coordinates;
  }

}