// ignore_for_file: prefer_const_constructors, unnecessary_new, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);

String l = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
RegExp regExl = new RegExp(l);

void ShowMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.purple,
      textColor: Colors.white,
      fontSize: 16.0);
}

showLoaderDialog(BuildContext context){
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context){
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.red,
            ),
             SizedBox(height: 15,),
             Container(
              margin: EdgeInsets.only(left: 7),
              child: const Text("Loading...")),

          ],
        ),
      );
    }),
  );

  showDialog(
    barrierDismissible: false,
    context: context, builder: (BuildContext context) {
      return alert;
    });
}



bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    ShowMessage("Both Fields are Empty");
    return false;
  } else if (email.isEmpty) {
    ShowMessage("Email is Empty");
    return false;
  } else if (password.isEmpty) {
    ShowMessage("password is Empty");
    return false;
  } else {
    return true;
  }
}

bool loginValidation1(
  String email,
) {
  if (email.isEmpty) {
    ShowMessage(" email is empty");
    return false;
  } else if (!regExp.hasMatch(email)) {
    ShowMessage("Please Try Valid Email");
    return false;
  } else {
    return true;
  }
}

bool loginValidation3(String password) {
  if (password.isEmpty) {
    ShowMessage("Password is Empty");
    return false;
  } else if (!regExl.hasMatch(password)) {
    ShowMessage("Create Strong password");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
  String email,
  String password,
) {
  if (email.isEmpty && password.isEmpty) {
    ShowMessage("All Fields are Empty");
    return false;
  } else if (email.isEmpty) {
    ShowMessage("Email is Empty");
    return false;
  } else if (!regExp.hasMatch(email)) {
    ShowMessage("Please Try Valid Email");
    return false;
  } else if (password.length < 8) {
    ShowMessage("password is too short");
    return false;
  } else if (password.isEmpty) {
    ShowMessage("password is Empty");
    return false;
  } else {
    return true;
  }
}
