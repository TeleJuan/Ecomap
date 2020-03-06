import 'package:ecomap/src/datasmodels/user_location.dart';
import 'package:ecomap/src/services/location_service.dart';
import 'package:flutter/material.dart';

import 'package:ecomap/src/routes/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
          create: (context)=>LocationService().locationStream,
          child: MaterialApp(
        title: 'Ecomap',
        debugShowCheckedModeBanner: false,
        routes: getApplicationRoutes() ,
      ),
    );
  }
}