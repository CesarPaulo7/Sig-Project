import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sig_project/pages/directiones.dart';
import 'package:sig_project/pages/mapa_page.dart';
import 'package:sig_project/pages/mapash.dart';
import 'package:sig_project/providers/ui_provider.dart';
import 'package:sig_project/widget/CustonNavigatorBar.dart';
import 'package:sig_project/widget/ScanButton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        elevation: 0,
        actions: [
          
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (() {
              
            }),  
            )
        ],
      ),

      body: _HomePageBody(),

      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}


class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //obtener el selectedMenuOpt
    final uiProvider = Provider.of<UiProvider>(context);

    //cambiar para mostrar la pagina
    final currentIndex= uiProvider.selectMenuOpt;

    switch( currentIndex){
      case 0: 
        return Mapash();
      case 1:
        return Directiones();
      default:
        return Mapash();
    }
}
}