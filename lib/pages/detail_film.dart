import 'package:flutter/material.dart';
import '../models/film.dart';

class DetailFilm extends StatelessWidget {
  final Film film;

  DetailFilm({required this.film});

  @override
  Widget build(BuildContext context) {
    String chemin = film.urlAffiche != null
        ? 'https://image.tmdb.org/t/p/w500/' + film.urlAffiche!
        : 'https://images.freeimages.com/images/large-previews/5eb/movieclapboard-1184339.jpg';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          film.titre,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    chemin,
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width * 0.9,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Résumé du film',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      film.description ?? 'Aucune description disponible.',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Date de sortie: ${film.dateDeSortie}',
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[500],
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          film.note != null ? film.note!.toStringAsFixed(1) : 'N/A',
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}