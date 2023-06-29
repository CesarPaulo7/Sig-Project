import 'package:flutter/material.dart';
import 'package:sig_project/class/map_marker.dart';
export '';

class CustomTextField extends StatelessWidget {

  


  final TextEditingController controller;
  final List<MapMarker> filterMarkers;
  final bool showList;
  final Function(int) selectMarker; 
//  final InputDecoration decoration;

  const CustomTextField({
    required this.controller,
    required this.filterMarkers,
    required this.showList,
    required this.selectMarker, 
 //   required this.decoration
  });

  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          ),
                              child: Column(
                                  children: [
                                          TextField(
                                               controller: controller,
                                               
                                               decoration: InputDecoration(
                                                       hintText: 'Buscar...',
                                                       border: InputBorder.none,
                                                       contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                      ),
                                              onChanged: (value) {
                                                  filterMarkers;
                                                  
                                              },
                                          ),                                                                         
                            Visibility(
                              visible: showList,
                              child: controller.text.isNotEmpty? //Aparece la lista con el filtro de busqueda y pregunta si es vacio
                               ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: filterMarkers.length,
                                      itemBuilder: (context, index) {
                                                final marker = filterMarkers[index];
                                                final color = marker.isSelected? Colors.red : Colors.blue;
                                                return ListTile(
                                                          title: Text(marker.title),
                                                          subtitle: Text(marker.address),
                                                          onTap: () {
                                                          // Acción al hacer clic en el marcador de la lista
                                                            print('Clic en el marcador de la lista: ${marker.title}');
                                                            selectMarker(mapMarkers.indexOf(marker));                                        
                                                          },
                                                          leading: Icon( Icons.location_on, color: color,),
                                                          
                                                );
                                               
                                              },
                                        )
                                       
                                        : SizedBox(),
                                       
                            ),
                                    ],
                                  ),
                                );
                      
  }
}