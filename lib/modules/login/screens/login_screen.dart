import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task/modules/login/controllers/login_getx_controller.dart';
import 'package:flutter_task/modules/registration/screens/registration_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginGetXController loginGetXController = Get.put(LoginGetXController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, bottom: 15, left: 15, right: 15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Icon(
                  Icons.note_alt,
                  color: Colors.black,
                  size: 50,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Login your account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: loginGetXController.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                      hintText: "Enter your email"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: loginGetXController.passwordControler,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      hintText: "Enter your password"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      loginGetXController.signUpWithEmailAndPassword();
                    }
                  },
                  child: const Text("Login"),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const CreateAccounScreen(), duration: Duration.zero);
                  },
                  child: const Text(
                    "Create a account SignUp",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
