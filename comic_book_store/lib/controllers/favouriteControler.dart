// lib/controllers/favoriteController.dart

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:comic_book_store/models/favoriteModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  final RxList<Favorite> favorites = <Favorite>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      isLoading.value = true;
      final snapshot = await _firestore
          .collection('favorites')
          .doc(user.email)
          .collection('userFavorites')
          .orderBy('addedAt', descending: true)
          .get();

      favorites.value = snapshot.docs
          .map((doc) => Favorite.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error loading favorites: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFavorite(int mangaId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore
          .collection('favorites')
          .doc(user.email)
          .collection('userFavorites')
          .doc(mangaId.toString())
          .delete();

      favorites.removeWhere((favorite) => favorite?.malId == mangaId);
      Get.snackbar('Success', 'Removed from favorites');
    } catch (e) {
      print('Error removing favorite: $e');
      Get.snackbar('Error', 'Failed to remove from favorites');
    }
  }
}