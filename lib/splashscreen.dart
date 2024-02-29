// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:pro_gamer/Screens/navigator.dart';
import 'package:pro_gamer/authentication/startpage.dart';
import 'package:pro_gamer/main.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    CheckUserLoggedIn() ;
    super.initState();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) =>const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 150,
          height: 300,
            child: Image.asset('lib/assets/Pro_Gaming.webp')
              ),
      ),
    );
  }

   Future<void>CheckUserLoggedIn() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    final _userLoggedIn = _sharedPrefs.getBool(SAVE_KEY_NAME);

    if (_userLoggedIn== null || _userLoggedIn== false) {
    gotoLogin();
    } else {
      
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(
            builder: (ctx1) =>const BottomNavigation()));
            
    }
  }
}