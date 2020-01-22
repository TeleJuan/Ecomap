import 'package:ecomap_borrador/src/pages/home_page.dart';
import 'package:ecomap_borrador/src/pages/home_temp_page.dart';
import 'package:ecomap_borrador/src/pages/login_page.dart';
import 'package:ecomap_borrador/src/pages/register_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/':(BuildContext context)=>HomeTempPage(),
    'home':(BuildContext context)=>HomePage(),
    'login':(BuildContext context)=>LoginPage(),
    'register':(BuildContext context)=>RegisterPage(),
  };
}