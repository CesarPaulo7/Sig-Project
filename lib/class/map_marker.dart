import 'package:latlong2/latlong.dart';

class MapMarker{

  final String image;
  final String address;
  final String title;
  final LatLng location;
  bool isSelected;

  MapMarker({required this.image,required this.address,required this.title,required this.location, this.isSelected=false});

  //set isSelected(bool isSelected) {}
}

final _locations = [
  LatLng(-17.775615,-63.198539),
  LatLng(-17.776279714197354, -63.19506034824415),
  LatLng(-17.776758935241386, -63.19574540522205),
  LatLng(-17.775165143261425, -63.195107039476504),
  LatLng(-17.775165143261425, -63.19636767771351),
  LatLng( -17.77414858261958, -63.19339579012501),
  LatLng(-17.77650352081639, -63.19193130400287),
];

const _path = 'assets';

final mapMarkers = [
  MapMarker(
    image: '${_path}/logo.png' , 
    address:'COMEDOR UNIVERSITARIO UAGRM', 
    title:'COMEDOR UNIVERSITARIO', 
    location: _locations[0],
    ),
  MapMarker(
    image:'${_path}/1.png', 
    address:'MODULO 236 UAGRM', 
    title:'Ciencias de la computacion y telecomunicaciones', 
    location:_locations[1],
    ),
    MapMarker(
    image:'${_path}/image.jpeg', 
    address:'UAGRM 3', 
    title:'PO 3', 
    location:_locations[2],
    ),
    MapMarker(
    image:'${_path}/image2.jpeg', 
    address:'UAGRM 4', 
    title:'CO 4', 
    location:_locations[3],
    ),
    MapMarker(
    image:'${_path}/image3.jpg', 
    address:'UAGRM 5', 
    title:'SO 5', 
    location:_locations[4],
    ),
    MapMarker(
    image:'${_path}/logo.png', 
    address:'UAGRM 6', 
    title:'NO 6', 
    location:_locations[5],
    ),
    MapMarker(
    image:'${_path}/1.png', 
    address:'UAGRM 7', 
    title:'NO 7', 
    location:_locations[6],
    ),
];