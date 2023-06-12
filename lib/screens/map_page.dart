
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../class/map_marker.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MyPage2State();
}

class _MyPage2State extends State<MapPage> {

  final TextEditingController _searchController= TextEditingController();
  List<MapMarker> _filteredMarkers = [];
  bool showList= true;

 @override
  void initState(){
    super.initState();
    _filteredMarkers= mapMarkers;
  }

  void _selectMarker(int index) {
    setState(() {
      for (int i = 0; i < mapMarkers.length; i++) {
        mapMarkers[i].isSelected = (i == index);
      }
      showList=false;
    });
  }

  void _filterMarkers(String searchText){
    setState(() {
      _filteredMarkers = mapMarkers.where((marker) => 
        marker.address.toLowerCase().contains(searchText.toLowerCase()) ||
        marker.title.toLowerCase().contains(searchText.toLowerCase())).toList();

    });
  }

  Future <Position>  _determinePosition() async{
    LocationPermission permission;
    permission= await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('error');
      }
    }
   return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation () async {
     Position position = await _determinePosition();
     print(position.latitude);
     print(position.longitude);
  }

  /*Future<void> moverCamara(LatLng position){
    final controller= await 
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
                title: Text('GEOLOCATOR'),
                backgroundColor: Colors.blue,
                centerTitle: true,
            ),
            body: Stack(
                children: [
                  FlutterMap( options: MapOptions(
                                    center: LatLng(-17.7762548, -63.1961685),
                                    zoom: 14,
                                    onTap: (tapPosition, point) {
                                    print("POSITION OBTENIDA: ${point.latitude},${point.longitude}");
                                    },
                          ),
                          children: [
                             TileLayer(
                              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                             ), 
                             MarkerLayer(
                              markers: _filteredMarkers.map((e) {
                                return Marker(
                                              point: e.location, 
                                              builder: (ctx) {
                                                            final color= e.isSelected ? Colors.red[700] : Colors.blue;
            
                                                             return IconButton(
                                                                   color: color, 
                                                                  onPressed: (){
                                                                    print('Click');                                       
                                                                  }, 
                                                                  
                                                                  icon: Icon(Icons.location_on)
                                                                  );
                                              }
                                                                  
                                              );
                              }).toList()
                             )
                          ],
                  
                  ),
               /*   Positioned( 
                              top: 10,
                              left: 10,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                              controller: _searchController,
                                              decoration: InputDecoration(
                                                      hintText: 'Buscar...',
                                                      border: InputBorder.none,
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 10)
                                                    ),
                                              onChanged: (value){
                                                _filterMarkers(value);
                                              },
                                          ),
                                        ),
                                        IconButton(onPressed: (){
                                                    _filterMarkers(_searchController.text); 
                                                    },
                                                    icon: Icon(Icons.search))
                                      ],
                                    ),                         
                                ),
                            
                              )*/
                       Positioned(
                          top: 10,
                          left: 10,
                          right: 10,
                          child: Container(
                              decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          ),
                              child: Column(
                                  children: [
                                          TextField(
                                               controller: _searchController,
                                               
                                               decoration: InputDecoration(
                                                       hintText: 'Buscar...',
                                                       border: InputBorder.none,
                                                       contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                      ),
                                              onChanged: (value) {
                                                  _filterMarkers(value);
                                                  showList=true;
                                              },
                                          ),
                            Visibility(
                              visible: showList,
                              child: _searchController.text.isNotEmpty? //Aparece la lista con el filtro de busqueda y pregunta si es vacio
                               ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _filteredMarkers.length,
                                      itemBuilder: (context, index) {
                                                final marker = _filteredMarkers[index];
                                                final color = marker.isSelected? Colors.red : Colors.blue;
                                                return ListTile(
                                                          title: Text(marker.title),
                                                          subtitle: Text(marker.address),
                                                          onTap: () {
                                                          // Acción al hacer clic en el marcador de la lista
                                                            print('Clic en el marcador de la lista: ${marker.title}');
                                                            _selectMarker(mapMarkers.indexOf(marker));                                        
                                                          },
                                                          leading: Icon( Icons.location_on, color: color,),
                                                          
                                                );
                                               
                                              },
                                        )
                                       
                                        : SizedBox(),
                                       
                            ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
          
                         ),
              
              floatingActionButton: FloatingActionButton(
                                  onPressed: () async{
                                      getCurrentLocation();
                                    }, 
                                  child:Icon(Icons.location_searching)
                                  )
    );
  }
}

