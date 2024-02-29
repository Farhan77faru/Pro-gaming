// ignore_for_file: prefer_final_fields, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_gamer/authentication/firebaseauth/firebase_auth.dart';
import 'package:pro_gamer/authentication/phone_auth/phone_otp.dart';
import 'package:pro_gamer/authentication/signup1.dart';
import 'package:pro_gamer/authentication/signin.dart';
import 'package:pro_gamer/constants/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {




  TextEditingController email = TextEditingController();

  FirebaseAuthHelper _auth = FirebaseAuthHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(5.0), 
          child: AppBar(
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 24, 25, 25),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: 150,
              child: Image.asset('lib/assets/Pro_Gaming.webp'),
            ),
           const SizedBox(
              height: 40,
            ),
           
          const  SizedBox(
              height: 10,
            ),
          
           const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: email,
                style:const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle:
                    const  TextStyle(color: Color.fromARGB(255, 135, 131, 131)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10), 
                    borderSide: const BorderSide(
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
                
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InkWell(
                onTap: () {
                  bool validated = loginValidation1(email.text);
                  if (validated) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage2(
                                  email: email.text,
                                )));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color:const Color.fromARGB(255, 10, 121, 241),
                  ),
                  height: 50,
                  width: double.infinity,
                  child: const Center(
                      child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
          const  SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const  Text(
                  'already have an Account,',
                  style: TextStyle(color: Colors.white),
                ),
               const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>const SignIn(),
                      ),
                    );
                  },
                  child:const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          const  SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 60),
                    child: Divider(
                      color: Colors.white,
                      thickness: 0.8,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'or continue with',
                    style: TextStyle(color: Color.fromARGB(255, 242, 222, 222)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 60),
                    child: Divider(
                      color: Colors.white,
                      thickness: 0.8,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          const  SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await _auth.googleSignIn(context);
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('lib/assets/Google logo.png')),
                ),
               const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                    await _auth.googleSignIn(context);
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('lib/assets/facebook-icon.png')),
                ),
              const  SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const PhoneAuth());
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      child: Image.network(
                          'http://clipart-library.com/img/1344166.png')),
                ),
              ],
            ),
          ]),
        ));
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
