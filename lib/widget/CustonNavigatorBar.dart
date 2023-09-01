import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sig_project/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex= uiProvider.selectMenuOpt;
    return BottomNavigationBar(
      onTap: (int i ) =>  uiProvider.selectMenuOpt= i,
      elevation: 0,
      currentIndex: currentIndex,
      items:<BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Mapa',
          ),
           BottomNavigationBarItem(
          icon: Icon(Icons.directions),
          label: 'Direcciones',
          )
      ]
      );

  }

}