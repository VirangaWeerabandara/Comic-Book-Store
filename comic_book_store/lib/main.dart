// lib/models/anime.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Anime {
  final int malId;
  final String title;
  final String synopsis;
  final String imageUrl;
  final double score;
  final String status;

  Anime({
    required this.malId,
    required this.title,
    required this.synopsis,
    required this.imageUrl,
    required this.score,
    required this.status,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return Anime(
      malId: data['mal_id'],
      title: data['title'],
      synopsis: data['synopsis'] ?? 'No synopsis available',
      imageUrl: data['images']['jpg']['image_url'] ?? '',
      score: (data['score'] ?? 0.0).toDouble(),
      status: data['status'] ?? 'Unknown',
    );
  }
}

// lib/services/jikan_service.dart

class JikanService {
  final String baseUrl = 'https://api.jikan.moe/v4';

  Future<List<Anime>> getTopAnime() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/top/anime'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((item) => Anime.fromJson({'data': item})).toList();
      } else {
        throw Exception('Failed to load anime');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Anime> getAnimeById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/$id'));

      if (response.statusCode == 200) {
        return Anime.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load anime details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

// lib/providers/anime_provider.dart

class AnimeProvider extends ChangeNotifier {
  final JikanService _jikanService = JikanService();
  List<Anime> _animeList = [];
  bool _isLoading = false;
  String _error = '';

  List<Anime> get animeList => _animeList;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchTopAnime() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _animeList = await _jikanService.getTopAnime();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// lib/screens/anime_list_screen.dart
// lib/screens/anime_list_screen.dart
class AnimeListScreen extends StatefulWidget {
  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => AnimeListScreen(),
    );
  }

  @override
  _AnimeListScreenState createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<AnimeProvider>().fetchTopAnime(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Anime'),
      ),
      body: Consumer<AnimeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${provider.error}'),
                  ElevatedButton(
                    onPressed: () => provider.fetchTopAnime(),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.animeList.length,
            itemBuilder: (context, index) {
              final anime = provider.animeList[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    anime.imageUrl,
                    width: 50,
                    height: 75,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error),
                  ),
                  title: Text(anime.title),
                  subtitle: Text(
                    anime.synopsis,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      anime.score.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    // Use pushNamed instead of directly creating a route
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: anime,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// lib/screens/anime_detail_screen.dart
class AnimeDetailScreen extends StatelessWidget {
  static Route<void> route(Anime anime) {
    return MaterialPageRoute(
      builder: (context) => AnimeDetailScreen(anime: anime),
    );
  }

  final Anime anime;

  const AnimeDetailScreen({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(anime.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                anime.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Score: ${anime.score}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        anime.status,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Synopsis',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    anime.synopsis,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// lib/main.dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AnimeProvider(),
      child: MaterialApp(
        title: 'Jikan Anime App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (_) => AnimeListScreen(),
              );
            case '/detail':
              final anime = settings.arguments as Anime;
              return AnimeDetailScreen.route(anime);
            default:
              return MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: Center(
                    child: Text('Route not found'),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
