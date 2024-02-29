// ignore_for_file: use_build_context_synchronously

import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:pro_gamer/constants/constants.dart';
import 'package:pro_gamer/firebasehelper/firebase_firestore.dart';
import 'package:pro_gamer/provider/app_provider.dart';
import 'package:provider/provider.dart';


class StripeHelper {
  static StripeHelper instance = StripeHelper();

  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(String amount,BuildContext context) async {
    try {
      paymentIntent = await createPaymentIntent('10000', 'USD');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US",
          currencyCode: "USD",
          testEnv: true);

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.light,
              merchantDisplayName: 'Farhan',
              googlePay: gpay)).then((value) => {});

      await displayPaymentSheet(context);
    } catch (err) {
      ShowMessage('error');
    }
  }

  Future<void> displayPaymentSheet(BuildContext context) async {
    AppProvider appProvider = Provider.of<AppProvider>(context,listen: false);
    try {
      await Stripe.instance.presentPaymentSheet().then((value)async {
       bool value = await FirebaseFirestoreHelper.instance
                          .uploadOrderedProductFirebase(
                              appProvider.getBuyProductList, context, "Paid");

                      appProvider.clearBuyProduct();

                      if (value) {
                        await Future.delayed(const Duration(seconds: 2));
                        Navigator.of(context, rootNavigator: true).pop();
                        Navigator.of(context).pop();
                      }
      });
    } catch (e) {
      ShowMessage('$e');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51Op2GqSI576AonkufXwg12BcNND6dFIXC7WahH6pvyxFEAfxQwiHvVujwlpbjP5MwXxjTIw35y11oZSfJTs9g12z00XWelec5U',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}