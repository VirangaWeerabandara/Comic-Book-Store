import 'comic_book.dart';

class User {
  String userID;
  String userName;
  String email;
  String password;
  List<ComicBook> purchasedComics;

  User({
    required this.userID,
    required this.userName,
    required this.email,
    required this.password,
    required this.purchasedComics,
  });

  bool register() {
    // Implementation here
    return true;
  }

  bool login(String email, String password) {
    // Implementation here
    return true;
  }

  List<ComicBook> viewPurchasedComics() {
    // Implementation here
    return purchasedComics;
  }

  void addComicToLibrary(ComicBook comic) {
    // Implementation here
    purchasedComics.add(comic);
  }
}
