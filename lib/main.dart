// ignore_for_file: constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:pro_gamer/provider/app_provider.dart';
import 'package:pro_gamer/splashscreen.dart';
import 'package:provider/provider.dart';

const SAVE_KEY_NAME = 'userLoggedIn';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey ="pk_test_51Op2GqSI576AonkuNXzu579kKzzovbKlb7aMMw2OrAIzgRRF2P6otMcBvOUmaT3pT9xbhOFGhpvxEF6yGthXy4xT00cTQq6wFY";
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void setLocale(Locale newLocale) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context)=>AppProvider(),
      child: GetMaterialApp(
       
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
