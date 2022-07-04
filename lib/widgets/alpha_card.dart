import 'package:flutter/material.dart';

class AlphaCard extends StatefulWidget {
  final String alpha;
  final String word;
  AlphaCard({required this.alpha, required this.word});

  @override
  State<AlphaCard> createState() => _AlphaCardState(alpha, word);
}

class _AlphaCardState extends State<AlphaCard> {
  String alpha;
  String word;
  String theText = "the Text";
  bool cardValue = false;

  _AlphaCardState(this.alpha, this.word);
  @override
  Widget build(BuildContext context) {
    Widget cardContent;

    switch (cardValue) {
      case false:
        {
          theText = alpha;
        }
        break;
      case true:
        {
          theText = word;
        }
        break;
    }
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: TextButton(
        child: Text(
          theText,
          style: TextStyle(fontSize: 24.0),
        ),
        onPressed: () {
          cardValue = !cardValue;
          setState(() {});
        },
      ),
    );
  }
}
