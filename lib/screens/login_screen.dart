import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:islam/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Login Screen")),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Enter Your Email"),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: passwordController,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(labelText: "Enter Your Password"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(
                Icons.login,
                size: 32,
              ),
              label: const Text(
                "Login",
                style: TextStyle(fontSize: 16.0),
              ),
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                try {
                  print("=============${emailController.text.trim()}");
                  print("=============${passwordController.text.trim()}");
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                } on FirebaseAuthException catch (e) {
                  print("===========error:$e");
                }
                navigatorKey.currentState!.popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
