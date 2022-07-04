import 'package:flutter/material.dart';

class UserText extends StatelessWidget {
  final String text;
  const UserText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}
