import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermovie/src/models/actores_model.dart';
import 'package:fluttermovie/src/models/peliculas_models.dart';
import 'package:fluttermovie/src/providers/pelicula_provider.dart';

class PeliculaDetalles extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula, context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _crearCasting(pelicula),
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _crearAppBar(Pelicula pelicula, BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(CupertinoIcons.back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 2.0,
      backgroundColor: Colors.black,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(pelicula.title, style: TextStyle(color: Colors.white, fontSize: 18.0),),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackground()),
          placeholder: AssetImage("assets/img/loading.gif"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
         Hero(tag: pelicula.uniqueId,
             child:  ClipRRect(
                 borderRadius: BorderRadius.circular(20.0),
                 child: Image(
                     image : NetworkImage(pelicula.getPosterIMG()),
                     height: 150.0
                 )
             ),),
          SizedBox(width: 20.0),
          Flexible(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(pelicula.title, style: TextStyle(fontSize: 20.0),),
              Text(pelicula.originalTitle),
              Row(
                children: <Widget>[
                  Icon(CupertinoIcons.heart_solid),
                  Text(pelicula.voteAverage.toString())
                ],
              )
            ],
          ))
        ],

      )
    );

  }

  Widget _descripcion(Pelicula pelicula) {

   return Container(
    padding: EdgeInsets.all(20.0),
    child : Text(pelicula.overview, textAlign: TextAlign.justify, style: TextStyle(fontSize: 17.0),)
   );


 }

  Widget _crearCasting(Pelicula pelicula) {

    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getActores(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if(snapshot.hasData){
            return _crearActoresPageView(snapshot.data);
          }else{
              return Center(child: CircularProgressIndicator(),);
          }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> listaActores) {

    return SizedBox(
      height: 220.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: listaActores.length,
        controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1
        ),
        itemBuilder: (context, i){ //la creacion de cada elemento por posicion de la lista
          return _actorTarjeta(listaActores[i]);
        },
        )
    );

  }


Widget _actorTarjeta(Actor actor){
  return Container(
    margin: EdgeInsets.all(5.0),
    child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: FadeInImage(
              placeholder: AssetImage("assets/img/no-image.jpg"),
              image: NetworkImage(actor.getFoto()),
              fit: BoxFit.cover
          ),
        ),
        Text(actor.name, textAlign: TextAlign.center)
      ],
    )
  );
}

}
