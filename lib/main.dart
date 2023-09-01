import 'package:flutter/material.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sig_project/pages/home_page.dart';
import 'package:sig_project/pages/mapa_page.dart';
import 'package:sig_project/providers/ui_provider.dart';

import 'package:sig_project/screens/map_page.dart';
import 'package:sig_project/screens/map_page2.dart';
import 'package:sig_project/screens/qr_page.dart';

import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new UiProvider()
        ),
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: 'home',
        routes: {
          'map_page':(context) => MapPage(),
          'map_page2':(context) => MapPage(),
        //  'qr_page':(context) => QrView(), 
          'home' : ( _ )=> HomePage(),
          'mapa': ( _ ) => MapaPage(), 
        },
    
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[200]
        ),
      ),
    );
  }
}


