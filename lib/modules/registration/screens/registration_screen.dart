import 'package:flutter/material.dart';
import 'package:flutter_task/modules/login/controllers/login_getx_controller.dart';
import 'package:flutter_task/modules/login/screens/login_screen.dart';
import 'package:flutter_task/modules/registration/controllers/create_account_controller.dart';
import 'package:get/get.dart';

class CreateAccounScreen extends StatefulWidget {
  const CreateAccounScreen({super.key});

  @override
  State<CreateAccounScreen> createState() => _CreateAccounScreenState();
}

class _CreateAccounScreenState extends State<CreateAccounScreen> {
  CreateAccountController createAccountController =
      Get.put(CreateAccountController());

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
                  "Create your account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: createAccountController.emailController,
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
                  controller: createAccountController.passwordControler,
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
                        createAccountController.createAccount();
                      }
                    },
                    child: const Text("Create your account")),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const LoginScreen(), duration: Duration.zero);
                  },
                  child: const Text(
                    "you have already account",
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
