import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotesgenerator/components/button.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String quote = "";
  void getQuote() async {
    var apiUrl = Uri.parse("https://api.quotable.io/random");
    var response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        quote = data['content'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void addToFavorites() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 169, 191),
        title: const Text(
          "quotify",
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.cyan,
        child: Column(children: [
          const DrawerHeader(
              child: Icon(
            Icons.quora_outlined,
            color: Colors.white,
            size: 140,
          )),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            leading: const Icon(
              Icons.home,
              color: Colors.white,
              size: 40,
            ),
            title: const Text(
              "Home",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 40,
            ),
            title: Text(
              "Favorites",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(quote,
                style: GoogleFonts.lora(
                    textStyle: const TextStyle(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                ))),
          )),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Button(text: "get quote", onPressed: getQuote),
              Button(text: "add to favorites", onPressed: addToFavorites)
            ],
          )
        ],
      ),
    );
  }
}
