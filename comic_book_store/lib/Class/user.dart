import 'comic_book.dart';

class User {
  String _userID;
  String _userName;
  String _email;
  String _password;

  User({
    required String userID,
    required String userName,
    required String email,
    required String password,
  })  : _userID = userID,
        _userName = userName,
        _email = email,
        _password = password;

  // Getters
  String get userID => _userID;
  String get userName => _userName;
  String get email => _email;
  String get password => _password;

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

  bool register() {
    // Implementation here
    return true;
  }

  bool login(String email, String password) {
    // Implementation here
    return true;
  }
}

class Buyer extends User {
  List<ComicBook> _purchasedComics;

  Buyer({
    required String userID,
    required String userName,
    required String email,
    required String password,
    required List<ComicBook> purchasedComics,
  })  : _purchasedComics = purchasedComics,
        super(
          userID: userID,
          userName: userName,
          email: email,
          password: password,
        );

  // Getter
  List<ComicBook> get purchasedComics => _purchasedComics;

  // Setter
  set purchasedComics(List<ComicBook> purchasedComics) {
    _purchasedComics = purchasedComics;
  }

  void addComicToLibrary(ComicBook comic) {
    _purchasedComics.add(comic);
  }

  List<ComicBook> viewPurchasedComics() {
    return _purchasedComics;
  }
}

class Seller extends User {
  List<ComicBook> _comicsForSale;

  Seller({
    required String userID,
    required String userName,
    required String email,
    required String password,
    required List<ComicBook> comicsForSale,
  })  : _comicsForSale = comicsForSale,
        super(
          userID: userID,
          userName: userName,
          email: email,
          password: password,
        );

  // Getter
  List<ComicBook> get comicsForSale => _comicsForSale;

  // Setter
  set comicsForSale(List<ComicBook> comicsForSale) {
    _comicsForSale = comicsForSale;
  }

  void addComicForSale(ComicBook comic) {
    _comicsForSale.add(comic);
  }

  void removeComicForSale(ComicBook comic) {
    _comicsForSale.remove(comic);
  }
}
