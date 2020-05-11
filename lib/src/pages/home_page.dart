import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermovie/src/providers/pelicula_provider.dart';
import 'package:fluttermovie/src/widgets/card_swiper_widget.dart';
import 'package:fluttermovie/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  
  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(centerTitle: true, 
                    title: Text("Películas en cines"),
                    backgroundColor: Colors.black,
                    elevation: 15.0,
                    actions: <Widget>[
                      IconButton(icon: Icon(CupertinoIcons.search), onPressed: (){})
                    ],),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
              _swiperTarjetas(),
              _footer(context)
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {

      return FutureBuilder(
        future: peliculasProvider.getEnCines(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if(snapshot.hasData){
            return CardSwiper(peliculas: snapshot.data);
          }else{
            return Container(
            height: 400.0,
            child: Center(child: CircularProgressIndicator()));
          }
         
        },
      );

  }

 Widget _footer(BuildContext context) {

   return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares',    style: TextStyle(color: Colors.white, fontSize: 16.0))
          ),
          SizedBox(height: 20.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares);//sin parentesis, porque solo es la definicion de la misma.
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
    ),
   );

 }
}