
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
//import 'package:sig_project/widget/CustomTextField.dart';
import '../class/map_marker.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MyPage2State();
}

class _MyPage2State extends State<MapPage> {

  
  //EXAMPLES 
  List<Polyline> Polylines = [
    Polyline(points: [LatLng(-17.775615,-63.198539),
    LatLng(-17.776758935241386, -63.19574540522205),
  LatLng(-17.776279714197354, -63.19506034824415),
  LatLng(-17.775165143261425, -63.195107039476504),
  LatLng(-17.775165143261425, -63.19636767771351),
  LatLng( -17.77414858261958, -63.19339579012501),
  LatLng(-17.77650352081639, -63.19193130400287),],
            color: Colors.redAccent,
            strokeWidth: 5)
  ];

  LatLng? MyUbicacion;

  //

  final TextEditingController _searchController= TextEditingController();
  List<MapMarker> _filteredMarkers = [];
  bool showList= true;

 @override
  void initState(){
    super.initState();
    _filteredMarkers= mapMarkers;
  }

  //Markers seleccionado
  void _selectMarker(int index) {
    setState(() {
      for (int i = 0; i < mapMarkers.length; i++) {
        mapMarkers[i].isSelected = (i == index);
      }
      showList=false;
    });
  }

//filtro de los markers
  void _filterMarkers(String searchText){
    setState(() {
      _filteredMarkers = mapMarkers.where((marker) => 
        marker.address.toLowerCase().contains(searchText.toLowerCase()) ||
        marker.title.toLowerCase().contains(searchText.toLowerCase())).toList();

    });
  }

  //DETERMINAR Y HALLAR MI POSICION
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

 // void getCurrentLocation () async {
 //    Position position = await _determinePosition();
 //    print(position.latitude);
 //    print(position.longitude);
 // }

   Future<void> getCurrentLocation () async {
     Position position = await _determinePosition();
     print(position.latitude);
     print(position.longitude);

     setState(() {
       MyUbicacion = LatLng(position.latitude, position.longitude);
     });
  }
  //*********************************** */

    MapController movController= MapController();
    void moverCamara(LatLng position) async{
    final zoom= 14.0;
    await movController.move(position,zoom); 
    }

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
                                mapController: movController, //para que se mueva a mi ubicacion
                                children: [  
                                    TileLayer(
                                    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    ), 

                                      //obtener mi ubicacion
                                      MyUbicacion != null ? 
                                      MarkerLayer(
                                        markers: [
                                          Marker(point: MyUbicacion!, 
                                          builder: (ctx) => Icon(Icons.location_on, color: Colors.red,) 
                                          ),
                                        ],
                                      ):SizedBox(),

                                   // PolylineLayer(
                                   //   polylines: Polylines.sublist(0),
                                   // ),

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

                    Positioned(
                      top: 5,
                      right: 20,
                      left: 20,
                      child: Container(
                        width:30,
                 
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          
                        children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Local....',
                                suffixIcon: Icon(Icons.person),
                                suffixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15)
                              ),
                            )
                        ],
                                          ),
                      )
                    ),
               
                       Positioned(      
                          top: 56,
                          left: 20,
                          right: 20,
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
                                                       suffixIcon: Icon(Icons.directions),
                                                       contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
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
                                      await getCurrentLocation();
                                      moverCamara(MyUbicacion!);
                                    }, 
                                  child:Icon(Icons.location_searching)
                                  )
    );
  }
}

