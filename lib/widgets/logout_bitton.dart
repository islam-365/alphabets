import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          maximumSize: const Size.fromHeight(50),
        ),
        icon: const Icon(
          Icons.arrow_back,
          size: 32,
        ),
        label: const Text(
          "SignOut",
          style: TextStyle(fontSize: 16.0),
        ),
        onPressed: () async {
          FirebaseAuth.instance.signOut();
        },
      ),
    );
  }
}
