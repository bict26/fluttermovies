import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttermovie/src/models/peliculas_models.dart';
import 'package:fluttermovie/src/providers/pelicula_provider.dart';

class SearchDelegateData extends SearchDelegate{

  String seleccion = '';
  final peliculaProvider = new PeliculasProvider();

  final peliculas = [
    "esto no es",
    "bajo la misma estrella",
    "hay amor",
    "princesa de las cuatros",
    "xvideos",
    "pornhub"
  ];

  final peliculasRecientes = [
    "Spindermas",
    "java",
    "joder",
    "cabreas",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro AppBar : example icono para limpiar el buscador
    return [
      
      IconButton(
          icon: Icon(CupertinoIcons.clear),
          onPressed: (){
            query = '';
          })
      
      
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //  Icono a la inzquierda del AppBar: icono de buscador o icono de regresar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe.

    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
        future: peliculaProvider.buscarPeliculas(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){
            if (snapshot.hasData) {
            if (snapshot.data != null) {
            final peliculas = snapshot.data;
            return ListView(
              children: peliculas.map((pelicula) {
              return ListTile(
              leading: FadeInImage(
              image: NetworkImage(pelicula.getPosterIMG()),
              placeholder: AssetImage("assets/img/no-image.jpg"),
              width: 50.0,
            ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, "detalle", arguments: pelicula);
                },
            );
            }).toList()
            );
            }
          }else {
              return Center(
                child: CircularProgressIndicator()
              );
            }
          }
    );

  }

}