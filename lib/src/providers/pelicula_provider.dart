import 'dart:async';
import 'dart:convert';
import 'package:fluttermovie/src/models/actores_model.dart';
import 'package:fluttermovie/src/models/peliculas_models.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider{

  String _apiKey = '1dcc747913a48a8728a58b80ef3fa15a';
  String _url = 'api.themoviedb.org';
  String _lenguaje = 'es-ES';

  int _populares = 0;
  bool _cargando = false;

  List<Pelicula> _listPopulares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStream(){
    _popularesStreamController?.close(); //si tiene algun valor, entonces cierra!
  }


  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{

    final resp = await http.get( url );
    final decodeData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);
    
    return peliculas.items;

  }


  Future<List<Pelicula>> getEnCines() async{

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language' : _lenguaje
    });

    return await _procesarRespuesta(url);
  }


  Future<List<Pelicula>> getPopulares() async{

    if(_cargando) return [];

    _cargando = true;

    _populares++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apiKey,
      'language' : _lenguaje,
      'page' : _populares.toString()
    });

    final resp = await _procesarRespuesta(url);

    _listPopulares.addAll(resp);

    popularesSink(_listPopulares);

    _cargando = false;

    return resp;
}


  Future<List<Actor>> getActores(String peliId) async{

    final url = Uri.https(_url, "3/movie/$peliId/credits",{
        'api_key' : _apiKey,
        'lenguage' : _lenguaje
    });


    final resp = await http.get(url);

    final decodeData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodeData['cast']);

    return cast.actores;
  }


  Future<List<Pelicula>> buscarPeliculas(String query) async{

    final url = Uri.https(_url, '3/search/movie', {
      'api_key' : _apiKey,
      'language' : _lenguaje,
      'query' : query
    });

    return await _procesarRespuesta(url);
  }



}
