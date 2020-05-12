import 'package:flutter/material.dart';
import 'package:fluttermovie/src/pages/home_page.dart';
import 'package:fluttermovie/src/pages/peliculas_detalles.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: "/",
      routes: {
        "/" : (context) => HomePage(),
        "detalle": (context) => PeliculaDetalles(),
      },
    );
  }
}