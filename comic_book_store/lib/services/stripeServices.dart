import 'package:comic_book_store/constants/consts.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeServices {
  StripeServices._();
  static final StripeServices stripeServices = StripeServices._();

  Future<void> makePayment() async {
    try {
      String? result = await _createPaymentIntent(100, 'usd');
      if (result != null) {
        print('Payment Intent Created: $result');
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: result,
            merchantDisplayName: 'Comic Book Store',
          ),
        );
        await _processPayment();
      } else {
        print('Failed to create Payment Intent');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        'amount': _calculateAmount(amount),
        'currency': currency,
      };
      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded"
          },
        ),
      );
      if (response.data != null) {
        print(response.data);
        return response.data['client_secret'];
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print('Error: $e');
    }
  }

  String _calculateAmount(int amount) {
    return (amount * 100).toString();
  }
}
