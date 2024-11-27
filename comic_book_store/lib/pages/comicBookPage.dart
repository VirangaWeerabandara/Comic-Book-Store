import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comic_book_store/api/jikan_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/manga.dart';

class ComicDetailPage extends StatefulWidget {
  final int mangaId;

  const ComicDetailPage({Key? key, required this.mangaId}) : super(key: key);

  @override
  _ComicDetailPageState createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage> {
  final JikanService _jikanService = JikanService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Manga? _manga;
  bool _isLoading = true;
  bool _isFavorite = false;
  bool _showFullSynopsis = false; // State variable to track synopsis display

  @override
  void initState() {
    super.initState();
    _loadMangaDetails();
    _checkFavoriteStatus();
  }

  Future<void> _loadMangaDetails() async {
    try {
      final mangaData = await _jikanService.getMangaDetails(widget.mangaId);
      setState(() {
        _manga = Manga.fromJson(mangaData);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print('Error loading manga details: $e');
    }
  }

  Future<void> _checkFavoriteStatus() async {
    try {
      final favoriteDoc = await _firestore
          .collection('favorites')
          .doc(widget.mangaId.toString())
          .get();

      setState(() {
        _isFavorite = favoriteDoc.exists;
      });
    } catch (e) {
      print('Error checking favorite status: $e');
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      DocumentReference favoriteRef =
          _firestore.collection('favorites').doc(widget.mangaId.toString());

      if (_isFavorite) {
        // Remove from favorites
        await favoriteRef.delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Removed from Favorites'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Add to favorites
        await favoriteRef.set({
          'malId': _manga!.malId,
          'title': _manga!.title,
          'imageUrl': _manga!.imageUrl,
          'score': _manga!.score,
          'synopsis': _manga!.synopsis,
          'genres': _manga!.genres,
          'status': _manga!.status,
          'publishedFrom': _manga!.publishedFrom,
          'publishedTo': _manga!.publishedTo,
          'chapters': _manga!.chapters,
          'type': _manga!.type,
          'addedAt': FieldValue.serverTimestamp(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to Favorites'),
            duration: Duration(seconds: 2),
          ),
        );
      }

      setState(() {
        _isFavorite = !_isFavorite;
      });
    } catch (e) {
      print('Error toggling favorite: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update favorites'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_manga == null) {
      return const Scaffold(
        body: Center(child: Text('Failed to load manga details')),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Cover Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    _manga!.imageUrl,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
                // Top Bar with Back Button and Favorite Button
                Positioned(
                  top: 40,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                      IconButton(
                        onPressed: _toggleFavorite,
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : Colors.black,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          _manga!.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      RatingBarIndicator(
                        rating: _manga!.score / 2,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Publication Info Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _InfoColumn(
                        title: 'Publication date',
                        value:
                            '${_manga!.publishedFrom?.split('T')[0] ?? ''} - ${_manga!.publishedTo?.split('T')[0] ?? ''}',
                      ),
                      _InfoColumn(
                        title: 'No. of issues',
                        value: '${_manga!.chapters ?? "N/A"}',
                      ),
                      _InfoColumn(
                        title: 'Language',
                        value: 'EN',
                      ),
                      _InfoColumn(
                        title: 'Age',
                        value: '16+',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Genres
                  const Text(
                    'Genres',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _manga!.genres
                        .map((genre) => _GenreChip(label: genre))
                        .toList(),
                  ),
                  const SizedBox(height: 24),

                  // Publishing
                  const Text(
                    'Publishing',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'I',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Image Comics',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Synopsis
                  const Text(
                    'Synopsis',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _showFullSynopsis
                        ? _manga!.synopsis
                        : _manga!.synopsis.substring(0, 100) + '...',
                    style: const TextStyle(
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showFullSynopsis = !_showFullSynopsis;
                      });
                    },
                    child: Text(_showFullSynopsis ? 'less' : 'more'),
                  ),
                  const SizedBox(height: 24),

                  // Authors
                  const Text(
                    'Authors',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const _AuthorTile(
                    imageUrl:
                        'https://img.icons8.com/color/48/user-male-circle--v1.png',
                    name: 'Robert Kirkman',
                    role: 'Writer',
                  ),
                  const SizedBox(height: 12),
                  const _AuthorTile(
                    imageUrl:
                        'https://img.icons8.com/color/48/user-male-circle--v1.png',
                    name: 'Ryan Ottley',
                    role: 'Illustrator',
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

class _InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const _InfoColumn({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _GenreChip extends StatelessWidget {
  final String label;

  const _GenreChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label),
    );
  }
}

class _AuthorTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String role;

  const _AuthorTile({
    required this.imageUrl,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Written by $name',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              role,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
