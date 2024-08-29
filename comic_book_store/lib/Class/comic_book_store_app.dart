import 'user.dart';
import 'comic_book.dart';

class ComicBookStoreApp {
  String storeName;
  String storeLogo;
  List<User> users;
  List<ComicBook> comics;

  ComicBookStoreApp({
    required this.storeName,
    required this.storeLogo,
    required this.users,
    required this.comics,
  });

  List<ComicBook> browseComics() {
    return comics;
  }

  List<ComicBook> searchComics(String query) {
    return comics.where((comic) => comic.title.contains(query)).toList();
  }

  bool buyComic(ComicBook comic, User user) {
    return true;
  }

  bool sellComic(ComicBook comic, User user) {
    return true;
  }
}
