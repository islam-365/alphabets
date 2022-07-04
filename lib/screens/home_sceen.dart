import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:islam/widgets/bottom_sheet.dart';

import '../databse/sqldb.dart';
import '../widgets/alpha_card.dart';
import '../widgets/logout_bitton.dart';
import '../widgets/user_information_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqlDb sqlDb = SqlDb();

  Future<List<Map>> readData(String table) async {
    List<Map> response = await sqlDb.read(table);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return MyBottomSheet();
            },
          );
          setState(() {});
        },
      ),
      appBar: AppBar(
        title: const Center(child: Text("Home Screen")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
                future: readData("users"),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: [
                        const SizedBox(width: double.infinity),
                        UserText(text: snapshot.data![0]['name']),
                        UserText(text: snapshot.data![0]['email']),
                        UserText(text: snapshot.data![0]['birthdate']),
                        LogoutButton(),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text("unexpected error"),
                    );
                  }
                }),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(top: 24.0),
              decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))),
              child: FutureBuilder(
                future: readData("alphabets"),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, i) {
                          return AlphaCard(
                            alpha: snapshot.data![i]['alpha'],
                            word: snapshot.data![i]['word'],
                          );
                        });
                  } else {
                    return const Center(
                      child: Text("unexpected error"),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
