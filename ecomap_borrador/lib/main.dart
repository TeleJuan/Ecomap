import 'package:flutter/material.dart';

import 'package:ecomap_borrador/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecomap',
      debugShowCheckedModeBanner: false,
      routes: getApplicationRoutes() ,
    );
  }
}