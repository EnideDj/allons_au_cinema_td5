class Film implements Comparable<Film> {
  final String titre;
  final String dateDeSortie;
  final double? note;
  final String? urlAffiche;
  final String? description;

  Film({
    required this.titre,
    required this.dateDeSortie,
    this.note,
    this.urlAffiche,
    this.description,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      titre: json['title'],
      dateDeSortie: json['release_date'],
      note: json['vote_average']?.toDouble(),
      urlAffiche: json['poster_path'],
      description: json['overview'],
    );
  }

  @override
  int compareTo(Film other) {
    if (note == null || other.note == null) {
      return 0;
    }
    if (note! < other.note!) {
      return 1;
    }
    if (note! > other.note!) {
      return -1;
    }
    return 0;
  }
}