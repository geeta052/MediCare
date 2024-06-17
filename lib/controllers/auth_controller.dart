import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  UserCredential? userCredential;
  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  get validateemail => null;

  get validpass => null;

  Future<void> authUser(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      try {
        isLoading(true);
        userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (userCredential != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential!.user!.uid)
              .set({
                'uid': userCredential!.user!.uid,
                'fullname': nameController.text,
                'password': passwordController.text,
                'email': emailController.text,
              });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup Successful")));
        }
        isLoading(false);
      } catch (e) {
        isLoading(false);
        if (e is FirebaseAuthException) {
          if (e.code == 'email-already-in-use') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email already in use")));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("FirebaseAuthException: ${e.message}")));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
        }
        log("$e");
      }
    }
  }

  Future<void> loginUser(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      try {
        isLoading(true);
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        isLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful")));
      } catch (e) {
        isLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong email or password")));
      }
    }
  }

  Future<void> storeUserData(String uid, String fullname, String email, String password) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'password': password,
    });
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegExp = RegExp(r'^[\w\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    RegExp passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (!passwordRegExp.hasMatch(value)) {
      return 'Your password must contain at least 8 characters, including upper/lowercase, a number, and a special character';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    if (value.length < 5) {
      return 'Name must be at least 5 characters long';
    }
    return null;
  }

  void signupUser(BuildContext context) {
    authUser(context);
  }
}
