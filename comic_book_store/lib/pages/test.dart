// lib/models/comic.dart
import 'package:comic_book_store/models/manga.dart';
import 'package:flutter/foundation.dart';

class Comic {
  final int malId;
  final String title;
  final String synopsis;
  final String imageUrl;
  final double score;
  final String status;
  final List<String> genres;
  final String? publishedFrom;
  final String? publishedTo;
  final int? chapters;

  Comic({
    required this.malId,
    required this.title,
    required this.synopsis,
    required this.imageUrl,
    required this.score,
    required this.status,
    required this.genres,
    this.publishedFrom,
    this.publishedTo,
    this.chapters,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return Comic(
      malId: data['mal_id'],
      title: data['title'],
      synopsis: data['synopsis'] ?? 'No synopsis available',
      imageUrl: data['images']?['jpg']?['large_image_url'] ?? data['images']?['jpg']?['image_url'] ?? '',
      score: (data['score'] ?? 0.0).toDouble(),
      status: data['status'] ?? 'Unknown',
      genres: (data['genres'] as List?)?.map((genre) => genre['name'] as String).toList() ?? [],
      publishedFrom: data['published']?['from'],
      publishedTo: data['published']?['to'],
      chapters: data['chapters'],
    );
  }
}

// lib/providers/comic_provider.dart
import 'package:flutter/material.dart';
import '../services/jikan_service.dart';
import '../models/comic.dart';

class ComicProvider extends ChangeNotifier {
  final JikanService _jikanService = JikanService();
  List<Comic> _trendingComics = [];
  List<Comic> _allComics = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String _error = '';

  List<Comic> get trendingComics => _trendingComics;
  List<Comic> get allComics => _allComics;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String get error => _error;

  Future<void> loadTrendingComics() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final comics = await _jikanService.getTrendingManga();
      _trendingComics = comics;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadAllComics() async {
    if (_isLoadingMore) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      final comics = await _jikanService.searchManga('');
      _allComics = comics;
    } catch (e) {
      _error = e.toString();
    }

    _isLoadingMore = false;
    notifyListeners();
  }
}

// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/comic_provider.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ComicProvider(),
      child: MaterialApp(
        title: 'Comic Book Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(),
      ),
    );
  }
}

// Update HomePage
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ComicProvider>().loadTrendingComics();
      context.read<ComicProvider>().loadAllComics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ComicProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StatusBar(),
                        const SizedBox(height: 24),
                        const Text(
                          'Hot takes',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const HotTakesCard(),
                        const SizedBox(height: 24),
                        const Text(
                          'Trending comics',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 220,
                          child: provider.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : TrendingComicsList(comics: provider.trendingComics),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Reading now',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const ReadingNowCard(),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'All Comics',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isGridView = !_isGridView;
                                });
                              },
                              icon: Icon(
                                _isGridView ? Icons.view_list : Icons.grid_view,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (provider.isLoadingMore)
                    const Center(child: CircularProgressIndicator())
                  else
                    _isGridView
                        ? ComicsGridView(comics: provider.allComics)
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ComicsList(comics: provider.allComics),
                          ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Update your TrendingComicsList, ComicsList, and ComicsGridView to use the new Comic model
class TrendingComicsList extends StatelessWidget {
  final List<Comic> comics;

  const TrendingComicsList({Key? key, required this.comics, required List<Manga> manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: comics.length,
      itemBuilder: (context, index) {
        final comic = comics[index];
        return Padding(
          padding: EdgeInsets.only(right: index != comics.length - 1 ? 16 : 0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ComicDetailPage(comicId: comic.malId),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    comic.imageUrl,
                    width: 140,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 140,
                        height: 220,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Update ComicDetailPage to use the new Comic model and Provider
class ComicDetailPage extends StatelessWidget {
  final int comicId;

  const ComicDetailPage({Key? key, required this.comicId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comic = context.read<ComicProvider>()
        .allComics
        .firstWhere((comic) => comic.malId == comicId);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... Rest of your ComicDetailPage implementation using the comic object
          ],
        ),
      ),
    );
  }
}