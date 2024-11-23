import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comic_book_store/models/manga.dart';

import '../api/jikan_service.dart';

class MangaController {
  final JikanService _jikanService = JikanService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Manga?> fetchMangaDetails(int mangaId) async {
    try {
      final mangaData = await _jikanService.getMangaDetails(mangaId);
      return Manga.fromJson(mangaData);
    } catch (e) {
      print('Error fetching manga details: $e');
      return null;
    }
  }

  Future<bool> isFavorite(int mangaId) async {
    try {
      final favoriteDoc = await _firestore
          .collection('favorites')
          .doc(mangaId.toString())
          .get();
      return favoriteDoc.exists;
    } catch (e) {
      print('Error checking favorite status: $e');
      return false;
    }
  }

  Future<void> toggleFavorite(Manga manga, bool isFavorite) async {
    try {
      final favoriteRef =
          _firestore.collection('favorites').doc(manga.malId.toString());

      if (isFavorite) {
        // Remove from favorites
        await favoriteRef.delete();
      } else {
        // Add to favorites
        // await favoriteRef.set({
        //   ...manga.toJson(),
        //   'addedAt': FieldValue.serverTimestamp(),
        // });
      }
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }
}
