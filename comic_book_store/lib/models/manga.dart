class Manga {
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
  final String? type;

  Manga({
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
    this.type,
  });

  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['images']['jpg']['large_image_url'],
      score: (json['score'] ?? 0).toDouble(),
      synopsis: json['synopsis'] ?? 'No synopsis available.',
      genres: (json['genres'] as List?)
              ?.map((genre) => genre['name'] as String)
              .toList() ??
          [],
      status: json['status'] ?? 'Unknown',
      publishedFrom: json['published']?['from'],
      publishedTo: json['published']?['to'],
      chapters: json['chapters'],
      type: json['type'],
    );
  }
}
