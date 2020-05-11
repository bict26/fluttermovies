import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttermovie/src/models/peliculas_models.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(peliculas[index].getPosterIMG()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover
            )
          );
          
          
      },
      itemCount: peliculas.length,
      layout: SwiperLayout.STACK,
    ),
  );
  }
}
