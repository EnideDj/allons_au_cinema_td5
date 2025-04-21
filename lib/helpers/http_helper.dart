import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/film.dart';

class HttpHelper {
  final String urlNouveauxFilms = 'https://api.themoviedb.org/3/movie/now_playing?api_key=9d4831eb53c466e47698be646c1b42da&language=fr-FR';
  final String urlRecherche = 'https://api.themoviedb.org/3/search/movie?api_key=9d4831eb53c466e47698be646c1b42da&language=fr-FR&query=';

  Future<List<Film>> recevoirNouveauxFilms() async {
    final response = await http.get(Uri.parse(urlNouveauxFilms));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List filmsList = data['results'];
      return filmsList.map((film) => Film.fromJson(film)).toList();
    } else {
      throw Exception('Erreur de chargement des films');
    }
  }

  Future<List<Film>> rechercherFilms(String titre) async {
    final response = await http.get(Uri.parse(urlRecherche + titre));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List filmsList = data['results'];
      return filmsList.map((film) => Film.fromJson(film)).toList();
    } else {
      return [];
    }
  }
}