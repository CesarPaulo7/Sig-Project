import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GEOLOCATOR'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
    );
  }
}