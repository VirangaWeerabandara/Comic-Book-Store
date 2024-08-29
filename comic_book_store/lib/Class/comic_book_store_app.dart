import 'user.dart';
import 'comic_book.dart';

class ComicBookStoreApp {
  String _storeName;
  String _storeLogo;
  List<User> _users;
  List<ComicBook> _comics;

  ComicBookStoreApp({
    required String storeName,
    required String storeLogo,
    required List<User> users,
    required List<ComicBook> comics,
  })  : _storeName = storeName,
        _storeLogo = storeLogo,
        _users = users,
        _comics = comics;

  // Getters
  String get storeName => _storeName;
  String get storeLogo => _storeLogo;
  List<User> get users => _users;
  List<ComicBook> get comics => _comics;

  // Setters
  set storeName(String storeName) {
    _storeName = storeName;
  }

  set storeLogo(String storeLogo) {
    _storeLogo = storeLogo;
  }

  set users(List<User> users) {
    _users = users;
  }

  set comics(List<ComicBook> comics) {
    _comics = comics;
  }

  List<ComicBook> browseComics() {
    return _comics;
  }

  List<ComicBook> searchComics(String query) {
    return _comics.where((comic) => comic.title.contains(query)).toList();
  }

  bool buyComic(ComicBook comic, User user) {
    return true;
  }

  bool sellComic(ComicBook comic, User user) {
    return true;
  }
}
