import 'package:flutter/material.dart';
import '../helpers/http_helper.dart';
import '../models/film.dart';
import 'detail_film.dart';

class ListeFilms extends StatefulWidget {
  @override
  _ListeFilmsState createState() => _ListeFilmsState();
}

class _ListeFilmsState extends State<ListeFilms> {
  List<Film> films = [];
  List<Film> filmsTous = [];
  int nombreDeFilms = 0;
  Icon iconVisible = Icon(Icons.search, color: Colors.white);
  Widget barreRecherche = Text('Films', style: TextStyle(color: Colors.white));
  bool triDecroissant = false;
  final HttpHelper helper = HttpHelper();
  String critereTri = 'Note';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialiser();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  Future<void> initialiser() async {
    List<Film> filmsRecuperes = await helper.recevoirNouveauxFilms();
    setState(() {
      films = filmsRecuperes;
      filmsTous = films;
      nombreDeFilms = films.length;
    });
  }

  void trier(String critere, bool inverser) {
    switch (critere) {
      case 'Note':
        films.sort((a, b) => a.compareTo(b));
        break;
      case 'Titre':
        films.sort((a, b) => a.titre.compareTo(b.titre));
        break;
      case 'Date':
        films.sort((a, b) => a.dateDeSortie.compareTo(b.dateDeSortie));
        break;
    }

    if (inverser) {
      films = films.reversed.toList();
    }

    setState(() {});
  }

  Future rechercher(String texte) async {
    if (texte.isEmpty) {
      setState(() {
        films = filmsTous;
        nombreDeFilms = films.length;
      });
    } else {
      films = await helper.rechercherFilms(texte);
      setState(() {
        nombreDeFilms = films.length;
      });
    }
  }

  void _onSearchChanged() {
    rechercher(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: barreRecherche,
        actions: <Widget>[
          IconButton(
            icon: iconVisible,
            onPressed: () {
              setState(() {
                if (iconVisible.icon == Icons.search) {
                  iconVisible = Icon(Icons.cancel, color: Colors.white);
                  barreRecherche = TextField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    decoration: InputDecoration(
                      hintText: 'Rechercher un film...',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                  );
                } else {
                  iconVisible = Icon(Icons.search, color: Colors.white);
                  barreRecherche = Text('Films', style: TextStyle(color: Colors.white));
                  searchController.clear();
                  rechercher('');
                }
              });
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.sort, color: Colors.white),
            onSelected: (value) {
              setState(() {
                critereTri = value;
                triDecroissant = !triDecroissant;
                trier(critereTri, triDecroissant);
              });
            },
            itemBuilder: (BuildContext context) {
              return ['Note', 'Titre', 'Date'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text('Trier par $choice', style: TextStyle(color: Colors.black)),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: films.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: nombreDeFilms,
        itemBuilder: (context, index) {
          Film film = films[index];
          String imagePath = film.urlAffiche != null
              ? 'https://image.tmdb.org/t/p/w92/' + film.urlAffiche!
              : 'https://images.freeimages.com/images/large-previews/5eb/movieclapboard-1184339.jpg';

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(imagePath, width: 60, height: 90, fit: BoxFit.cover),
                ),
                title: Text(
                  film.titre,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      film.dateDeSortie,
                      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow[500]),
                        Text(film.note?.toStringAsFixed(1) ?? "N/A"),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DetailFilm(film: films[index])),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}