import 'package:flutter/material.dart';
import 'package:flutter_task/modules/dashboard/screens/home_screen.dart';
import 'package:flutter_task/services/database_helper.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginGetXController extends GetxController {
  final RxBool isLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordControler = TextEditingController();

  Future<void> signUpWithEmailAndPassword() async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();

      isLoading.value = true;
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordControler.text,
      );
      await databaseHelper
          .insertUserData(userCredential.user!.email.toString(),
              userCredential.user!.displayName.toString())
          .then((value) {
        Get.to(const HomeScreen(), duration: Duration.zero);
      });

      // User signed up successfully
      print('User signed up successfully: $userCredential');
      // You can add any additional logic here after successful sign-up, such as navigating to a new screen, etc.
    } catch (e) {
      // Handle sign-up errors
      print('Sign-up failed: $e');
      String errorMessage = _mapErrorMessage(e);
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      // You can add specific error handling here based on the type of error received
    } finally {
      isLoading.value = false;
    }
  }

  String _mapErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'The account already exists for that email.';
        case 'invalid-email':
          return 'The email address is not valid.';
        default:
          return 'An error occurred while signing up. Please try again later.';
      }
    } else {
      return 'An error occurred while signing up. Please try again later.';
    }
  }
}
