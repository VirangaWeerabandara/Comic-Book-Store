class User {
  final String uid;
  final String fullName;
  final String email;
  final String contactNumber;

  User({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.contactNumber,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'fullName': fullName,
        'email': email,
        'contactNumber': contactNumber,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json['uid'],
        fullName: json['fullName'],
        email: json['email'],
        contactNumber: json['contactNumber'],
      );
}
