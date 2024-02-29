// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_gamer/Screens/navigator.dart';
import 'package:pro_gamer/constants/constants.dart';
import 'package:pro_gamer/main.dart';
import 'package:pro_gamer/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                height: 150,
                child: Image.asset('lib/assets/Pro_Gaming.webp'),
              ),
              SizedBox(height: 20),
              Padding(
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
              SizedBox(width: 10),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextFormField(
                  readOnly: true,
                  style: TextStyle(color: Colors.white),
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
                    hintText: widget.email,
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 135, 131, 131)),
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
                  controller: name,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 135, 131, 131)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10), 
                      borderSide: BorderSide(
                        color: Colors.blue, 
                        width: 2.0, 
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.green, 
                        width: 2.0, 
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextFormField(
                  controller: phone,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Phone number',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 135, 131, 131)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10), 
                      borderSide: BorderSide(
                        color: Colors.blue, 
                        width: 2.0, 
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.green, 
                        width: 2.0, 
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: password,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
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
                      validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
        
                    if (!RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{8,}$')
                        .hasMatch(value)) {
                      return 'Password must contain at least one\n lowercase letter, one uppercase letter, and\n one digit';
                    }
                    return null;
                  },
                ),
              ),
              
              SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      UserCredential userCredential =
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                        email: widget.email,
                        password: password.text,
                      );
                      UserModel userModel = UserModel(
                          id: userCredential.user!.uid,
                          email: widget.email,
                          phonenumber: phone.text,
                          password: password.text,
                          name: name.text,
                          image: null);

                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(userModel.id)
                          .set(userModel.toJson());

                      User? user = userCredential.user;

                      if (user != null) {
                        print("User logged in: ${user.uid}");

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigation()),
                          (route) => false,
                        );

                        final _sharedPrefs =
                            await SharedPreferences.getInstance();
                        await _sharedPrefs.setBool(SAVE_KEY_NAME, true);
                      } else {
                        print("Login failed: User is null");
                      }
                    } catch (e) {
                      print("Error during login: $e");
                      ShowMessage('Invalid Email');
                    }
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
                        'SIGN IN',
                        style: TextStyle(
                          color: Color.fromARGB(255, 242, 222, 222),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
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
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
