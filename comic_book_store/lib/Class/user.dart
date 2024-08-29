import 'comic_book.dart';

class User {
  String _userID;
  String _userName;
  String _email;
  String _password;
  List<ComicBook> _purchasedComics;

  User({
    required String userID,
    required String userName,
    required String email,
    required String password,
    required List<ComicBook> purchasedComics,
  })  : _userID = userID,
        _userName = userName,
        _email = email,
        _password = password,
        _purchasedComics = purchasedComics;

  // Getters
  String get userID => _userID;
  String get userName => _userName;
  String get email => _email;
  String get password => _password;
  List<ComicBook> get purchasedComics => _purchasedComics;

  // Setters
  set userID(String userID) {
    _userID = userID;
  }

  set userName(String userName) {
    _userName = userName;
  }

  set email(String email) {
    _email = email;
  }

  set password(String password) {
    _password = password;
  }

  set purchasedComics(List<ComicBook> purchasedComics) {
    _purchasedComics = purchasedComics;
  }

  bool register() {
    // Implementation here
    return true;
  }

  bool login(String email, String password) {
    // Implementation here
    return true;
  }

  List<ComicBook> viewPurchasedComics() {
    return _purchasedComics;
  }

  void addComicToLibrary(ComicBook comic) {
    _purchasedComics.add(comic);
  }
}
