// ignore_for_file: avoid_print, prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_gamer/Screens/navigator.dart';
import 'package:pro_gamer/constants/constants.dart';
import 'package:pro_gamer/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, });



  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController password = TextEditingController();
   TextEditingController email = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(5.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 24, 25, 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin:const EdgeInsets.all(20),
              height: 150,
              child: Image.asset('lib/assets/Pro_Gaming.webp'),
            ),
           const SizedBox(height: 20),
           const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Sign in to your Pro Gaming Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 242, 222, 222),
                ),
              ),
            ),
           const SizedBox(width: 10),
           const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: TextFormField(
                controller: email,
                style:const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.edit_note_outlined,
                      color: Colors.white,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[800],
                  hintText: "Email",
                  hintStyle:
                    const  TextStyle(color: Color.fromARGB(255, 135, 131, 131)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: TextFormField(
                style:const TextStyle(color: Colors.white),
                controller: password,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:const BorderSide(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                ),
              ),
            ),
          const  SizedBox(height: 40),
          const  Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Forgot Your Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
          const  SizedBox(height: 40),
            InkWell(
              onTap: () async {
          

               
                  try {
                    UserCredential userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email:email.text ,
                      password: password.text,
                    );

                    User? user = userCredential.user;

                    if (user != null) {
                      print("User logged in: ${user.uid}");

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavigation()),
                        (route) => false,
                      );

                      final _sharedPrefs = await SharedPreferences.getInstance();
                      await _sharedPrefs.setBool(SAVE_KEY_NAME, true);
                    } else {
                      print("Login failed: User is null");
                    }
                  } catch (e) {
                    print("Error during login: $e");
                    ShowMessage('Invalid Email');
                  }
                
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 10, 121, 241),
                  ),
                  height: 50,
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      'Login In',
                      style: TextStyle(
                        color: Color.fromARGB(255, 242, 222, 222),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Back to',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                     child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  child: Text(
                    'all options',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                ),
             ) ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
