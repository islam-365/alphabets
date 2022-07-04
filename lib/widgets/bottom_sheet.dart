import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../databse/sqldb.dart';

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({Key? key}) : super(key: key);

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  SqlDb sqlDb = SqlDb();

  final alphaController = TextEditingController();
  final wordController = TextEditingController();

  @override
  void dispose() {
    alphaController.dispose();
    wordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 2 / 3,
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          TextField(
            controller: alphaController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: "Enter The alphabets"),
          ),
          TextField(
            controller: wordController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: "Enter the Word"),
          ),
          ElevatedButton(
            child: const Text('Add'),
            onPressed: () async {
              int response = await sqlDb.insert("alphabets", {
                "alpha": "${alphaController.text.trim()}",
                "word": "${wordController.text.trim()}",
              });
              if (kDebugMode) {
                print("the response is :$response");
              }
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
