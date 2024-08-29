class Payment {
  String paymentID;
  double amount;
  DateTime date;
  String paymentMethod;

  Payment({
    required this.paymentID,
    required this.amount,
    required this.date,
    required this.paymentMethod,
  });

  bool processPayment(double amount, String method) {
    return true;
  }

  bool refundPayment(String paymentID) {
    return true;
  }
}
