import 'package:flutter/material.dart';
import 'package:sig_project/screens/map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'map_page',
      routes: {
        'map_page':(context) => MapPage(), 
      },

      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[200]
      ),
    );
  }
}


