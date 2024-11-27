class Favorite {
  final String userEmail;
  final int malId;
  final String title;
  final String imageUrl;
  final double score;
  final String synopsis;
  final List<String> genres;
  final String status;
  final String? publishedFrom;
  final String? publishedTo;
  final int? chapters;
  final String type;

  Favorite({
    required this.userEmail,
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
    required this.synopsis,
    required this.genres,
    required this.status,
    this.publishedFrom,
    this.publishedTo,
    this.chapters,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'malId': malId,
      'title': title,
      'imageUrl': imageUrl,
      'score': score,
      'synopsis': synopsis,
      'genres': genres,
      'status': status,
      'publishedFrom': publishedFrom,
      'publishedTo': publishedTo,
      'chapters': chapters,
      'type': type,
    };
  }

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      userEmail: json['userEmail'],
      malId: json['malId'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      score: json['score'],
      synopsis: json['synopsis'],
      genres: List<String>.from(json['genres']),
      status: json['status'],
      publishedFrom: json['publishedFrom'],
      publishedTo: json['publishedTo'],
      chapters: json['chapters'],
      type: json['type'],
    );
  }
}
