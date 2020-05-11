import 'package:flutter/material.dart';
import 'package:fluttermovie/src/models/peliculas_models.dart';

class MovieHorizontal extends StatelessWidget {
 
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

    
  MovieHorizontal({ @required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {

      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        siguientePagina();
      }

    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller:_pageController,
        //children: _listadoTarjeta(),
        itemCount: peliculas.length,
        itemBuilder: (context, i){
          return _tarjetas(context, peliculas[i]);
        },
      ),
    );
  }

  Widget _tarjetas(BuildContext context, Pelicula pelicula){
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage( pelicula.getPosterIMG() ),
              placeholder: AssetImage("assets/img/no-image.jpg"),
              fit: BoxFit.cover,
              height: 100.0,
            ),
          ),
          Text(pelicula.title, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white),)
        ],
      ),

    );
  }

 List<Widget> _listadoTarjeta() {

   return peliculas.map( (pelicula) {
     
      return Container(
          margin: EdgeInsets.only(right: 10.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage( pelicula.getPosterIMG() ),
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  fit: BoxFit.cover,
                  height: 100.0,
                ),
              ),
              Text(pelicula.title, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white),)
            ],
          ),

      );


   }).toList();

 }
}