import 'package:ecomap/src/pages/home_page.dart';
import 'package:ecomap/src/pages/home_temp_page.dart';
import 'package:ecomap/src/pages/login_page.dart';
import 'package:ecomap/src/pages/profile_page.dart';
import 'package:ecomap/src/pages/recycle_page.dart';
import 'package:ecomap/src/pages/register_page.dart';
import 'package:ecomap/src/pages/box_page.dart';

import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    //'/':(BuildContext context)=>HomeTempPage(),
    //'/':(BuildContext context)=>MainPage(),
    '/':(BuildContext context)=>HomePage(),
    'login':(BuildContext context)=>LoginPage(),
    'register':(BuildContext context)=>RegisterPage(),
    'recycle':(BuildContext context)=>RecyclePage(),
    'profile':(BuildContext context)=>ProfilePage(),
    'box':(BuildContext context)=>BoxPage(),
  };
}