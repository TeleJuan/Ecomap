import 'package:ecomap_borrador/main.dart';
import 'package:ecomap_borrador/src/pages/home_page.dart';
import 'package:ecomap_borrador/src/pages/home_temp_page.dart';
import 'package:ecomap_borrador/src/pages/login_page.dart';
import 'package:ecomap_borrador/src/pages/profile_page.dart';
import 'package:ecomap_borrador/src/pages/recycle_page.dart';
import 'package:ecomap_borrador/src/pages/register_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/':(BuildContext context)=>HomeTempPage(),
    //'/':(BuildContext context)=>MainPage(),
    'home':(BuildContext context)=>HomePage(),
    'login':(BuildContext context)=>LoginPage(),
    'register':(BuildContext context)=>RegisterPage(),
    'recycle':(BuildContext context)=>RecyclePage(),
    'profile':(BuildContext context)=>ProfilePage(),
  };
}