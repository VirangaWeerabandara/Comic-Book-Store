import 'package:comic_book_store/components/bookList.dart';
import 'package:comic_book_store/components/readingNowCard.dart';
import 'package:flutter/material.dart';
import 'package:comic_book_store/api/jikan_service.dart';
import 'package:comic_book_store/pages/comicBookPage.dart';
import '../models/manga.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final JikanService _jikanService = JikanService();
  List<Manga> _trendingManga = [];
  List<Manga> _allManga = [];
  bool _isLoading = true;
  bool _isLoadingAll = true;
  bool _isLoadingMore = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadTrendingManga();
    _loadAllManga();
  }

  Future<void> _loadTrendingManga() async {
    try {
      final mangaData = await _jikanService.getTrendingManga();
      setState(() {
        _trendingManga = mangaData.map((data) => Manga.fromJson(data)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print('Error: $e');
    }
  }

  Future<void> _loadAllManga() async {
    try {
      final mangaData = await _jikanService.getAllComics(page: _currentPage);
      setState(() {
        _allManga
            .addAll(mangaData.map((data) => Manga.fromJson(data)).toList());
        _isLoadingAll = false;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingAll = false;
        _isLoadingMore = false;
      });
      print('Error: $e');
    }
  }

  void _loadMoreManga() {
    if (!_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
        _currentPage++;
      });
      _loadAllManga();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                !_isLoadingMore) {
              _loadMoreManga();
            }
            return false;
          },
          child: SingleChildScrollView(
            child: Padding(
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
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : TrendingComicsList(manga: _trendingManga),
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
                  const Text(
                    'All Books',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _isLoadingAll
                      ? const Center(child: CircularProgressIndicator())
                      : BookList(books: _allManga),
                  if (_isLoadingMore)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatusBar extends StatelessWidget {
  const StatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          '9:41',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(Icons.signal_cellular_alt, size: 18),
        SizedBox(width: 8),
        Icon(Icons.wifi, size: 18),
        SizedBox(width: 8),
        Icon(Icons.battery_full, size: 18),
      ],
    );
  }
}

class HotTakesCard extends StatelessWidget {
  const HotTakesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFFFF4537),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: Image.network(
              'https://raw.githubusercontent.com/BOOM-COMICS/assets/main/brzrkr.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'New Issue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'BRZRKR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TrendingComicsList extends StatelessWidget {
  final List<Manga> manga;

  const TrendingComicsList({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: manga.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: index != manga.length - 1 ? 16 : 0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ComicDetailPage(mangaId: manga[index].malId),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    manga[index].imageUrl,
                    width: 140,
                    height: 220,
                    fit: BoxFit.cover,
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
